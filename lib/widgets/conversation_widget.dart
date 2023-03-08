import 'package:flutter/material.dart';

import 'app_bar_widget.dart';

class Message {
  Message({required this.id, required this.authorId, required this.content});
  final String id;
  final String authorId;
  final String content;
}

final data = [
  Message(id: '1', authorId: '1', content: 'Hello World!'),
  Message(id: '2', authorId: '2', content: 'My name is not World'),
  Message(id: '3', authorId: '1', content: 'Generally it is'),
  Message(id: '4', authorId: '2', content: 'I am not General Lee either...\nDo not let it happen again'),
];

const primaryColor = Color(0xff203152);
const greyColor = Color(0xffaeaeae);

class ConversationWidget extends StatefulWidget {
  const ConversationWidget({Key? key, required this.recipientId}) : super(key: key);

  final String recipientId;

  @override
  ConversationWidgetState createState() => ConversationWidgetState();
}

class ConversationWidgetState extends State<ConversationWidget> {
  final messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
            itemBuilder: (context, index) => buildMessage(data[index]),
            itemCount: data.length,
            reverse: true,
          ),
          buildInput()
        ],
      ),
    );
  }

  Widget buildMessage(Message message) {
    final children = [
      const CircleAvatar(
        backgroundImage: NetworkImage('http://placekitten.com/50/50'),
        radius: 18,
      ),
      const SizedBox(
        width: 10,
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(color: greyColor, borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(10),
        child: Text(
          message.content,
          style: const TextStyle(color: primaryColor),
        ),
      ),
      const Spacer()
    ];
    return Row(
      children: message.authorId == widget.recipientId ? children : children.reversed.toList(),
    );
  }

  Widget buildInput() {
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
                onSubmitted: (_) {
                  sendMessage();
                },
              ),
            ),
            IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.send),
            )
          ],
        ),
      ),
    );
  }

  void sendMessage() {
    print(messageController.text);
    messageController.clear();
  }
}
