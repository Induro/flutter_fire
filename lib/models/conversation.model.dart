import 'message.model.dart';

class Conversation {
  Conversation({required this.participants, required this.messages});

  Conversation.fromFirestore(Map<String, dynamic> data)
      : participants = List.from(data[participantsKey]).map((e) => e as String).toList(),
        messages = List.from(data[messagesKey]).map((d) => Message.fromFirestore(d)).toList();

  static const participantsKey = 'participants';
  static const messagesKey = 'messages';

  final List<String> participants;
  final List<Message> messages;

  Map<String, dynamic> toFirestore() {
    final data = <String, dynamic>{
      participantsKey: participants,
      messagesKey: messages.map((message) => message.toFirestore())
    };
    return data;
  }
}
