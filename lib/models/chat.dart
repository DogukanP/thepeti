import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String sender;
  final String receiver;
  final bool seen;
  final Timestamp createdDate;
  final String lastMessage;

  Chat(
      {this.seen,
      this.sender,
      this.receiver,
      this.createdDate,
      this.lastMessage});

  Chat.fromMap(Map<String, dynamic> map)
      : sender = map['sender'],
        receiver = map['receiver'],
        seen = map['seen'],
        createdDate = map['createdDate'],
        lastMessage = map['lastMessage'];

  Map<String, dynamic> toMap() {
    return {
      'sender': sender,
      'receiver': receiver,
      'seen': seen,
      'createdDate': createdDate ?? FieldValue.serverTimestamp(),
      'lastMessage': lastMessage,
    };
  }

  @override
  String toString() {
    return 'Message{sender: $sender,receiver: $receiver,seen: $seen,createdDate: $createdDate,lastMessage: $lastMessage}';
  }
}
