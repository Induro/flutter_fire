import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  Message({required this.authorId, required this.content, required this.sentAt});

  Message.fromFirestore(Map<String, dynamic> data)
      : authorId = data[authorIdKey],
        content = data[contentKey],
        sentAt = data[sentAtKey];

  static const authorIdKey = 'authorId';
  static const contentKey = 'content';
  static const sentAtKey = 'sentAt';

  final String authorId;
  final String content;
  final Timestamp sentAt;

  Map<String, dynamic> toFirestore() {
    return <String, dynamic>{authorIdKey: authorId, contentKey: content, sentAtKey: sentAt};
  }
}
