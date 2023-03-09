import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire/models/contact.model.dart';

import '../models/conversation.model.dart';
import '../models/message.model.dart';
import 'app_bar_widget.dart';

const blueColor = Color(0xff203152);
const greyColor = Color(0xffaeaeae);
const chatBackground = Color(0xffE8E8E8);

class ConversationContext {
  ConversationContext(
      {required this.senderId,
      this.senderPhotoURL,
      required this.recipientId,
      this.recipientPhotoURL,
      required this.conversationId});

  final String senderId;
  final String? senderPhotoURL;
  final String recipientId;
  final String? recipientPhotoURL;
  final String conversationId;
}

class ConversationWidget extends StatefulWidget {
  const ConversationWidget({Key? key, required this.recipientId}) : super(key: key);

  final String recipientId;

  @override
  ConversationWidgetState createState() => ConversationWidgetState();
}

class ConversationWidgetState extends State<ConversationWidget> {
  final db = FirebaseFirestore.instance;
  final messageController = TextEditingController();
  final messageFocus = FocusNode();

  @override
  void dispose() {
    messageController.dispose();
    messageFocus.dispose();
    super.dispose();
  }

  Future<ConversationContext?> getConversationContext() async {
    // get the sender
    final sender = FirebaseAuth.instance.currentUser;
    if (sender == null) {
      print('Sender does not exist');
      return null;
    }

    // get the recipient
    final recipientDoc = await db.collection('users').doc(widget.recipientId).get();
    if (!recipientDoc.exists) {
      print('Recipient does not exist ${widget.recipientId}');
      return null;
    }
    final recipient = Contact.fromFirestore(recipientDoc.data()!);

    // verify the conversation exists
    final participantIds = [sender.uid, recipient.id];
    participantIds.sort();
    final conversationId = participantIds.join('_');
    final conversationRef = db.collection('conversations').doc(conversationId);
    final conversation = await conversationRef.get();

    // create it if it doesn't
    if (!conversation.exists) {
      final conversation = Conversation(participants: [sender.uid, recipient.id], messages: []);
      await conversationRef.set(conversation.toFirestore());
    }

    return ConversationContext(
      senderId: sender.uid,
      senderPhotoURL: sender.photoURL,
      recipientId: recipient.id,
      recipientPhotoURL: recipient.photoURL,
      conversationId: conversationId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: FutureBuilder(
        future: getConversationContext(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text("You or your friends aren't real!"));
          }
          return buildConversation(snapshot.data!);
        },
      ),
    );
  }

  Widget buildConversation(ConversationContext conversationContext) {
    final conversation = db.collection('conversations').doc(conversationContext.conversationId).snapshots();

    return Stack(
      children: [
        StreamBuilder(
          stream: conversation,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: Text('Do you feel lonely?'));
            }
            final conversation = Conversation.fromFirestore(snapshot.data!.data()!);
            conversation.messages.sort((a, b) => b.sentAt.compareTo(a.sentAt));

            return Container(
                color: chatBackground,
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
                  itemBuilder: (context, index) => buildMessage(conversationContext, conversation.messages[index]),
                  itemCount: conversation.messages.length,
                  reverse: true,
                ));
          },
        ),
        buildInput(conversationContext)
      ],
    );
  }

  Widget buildMessage(ConversationContext conversationContext, Message message) {
    String? photoURL;
    Color backgroundColor;
    Color textColor;

    if (message.authorId == conversationContext.senderId) {
      photoURL = conversationContext.senderPhotoURL;
      backgroundColor = greyColor;
      textColor = blueColor;
    } else {
      photoURL = conversationContext.recipientPhotoURL;
      backgroundColor = blueColor;
      textColor = greyColor;
    }

    final children = [
      CircleAvatar(
        backgroundImage: photoURL != null ? NetworkImage(photoURL) : null,
        radius: 18,
      ),
      const SizedBox(
        width: 10,
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(10),
        child: Text(
          message.content,
          style: TextStyle(color: textColor),
        ),
      ),
      const Spacer()
    ];
    return Row(
      children: message.authorId == widget.recipientId ? children : children.reversed.toList(),
    );
  }

  Widget buildInput(ConversationContext conversationContext) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                autofocus: true,
                controller: messageController,
                decoration: const InputDecoration(
                  hintText: 'Type a message',
                  contentPadding: EdgeInsets.all(10.0),
                ),
                focusNode: messageFocus,
                onSubmitted: (_) {
                  sendMessage(conversationContext);
                },
              ),
            ),
            IconButton(
              onPressed: () {
                sendMessage(conversationContext);
              },
              icon: const Icon(Icons.send),
            )
          ],
        ),
      ),
    );
  }

  Future<void> sendMessage(ConversationContext conversationContext) async {
    final message =
        Message(authorId: conversationContext.senderId, content: messageController.text, sentAt: Timestamp.now());
    final update = <String, dynamic>{
      Conversation.messagesKey: FieldValue.arrayUnion([message.toFirestore()])
    };
    await db.collection('conversations').doc(conversationContext.conversationId).update(update);
    messageController.clear();
    messageFocus.requestFocus();
  }
}
