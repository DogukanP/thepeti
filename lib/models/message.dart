import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String receiverId;
  final bool isFromMe;
  final Timestamp createdDate;
  final String message;

  Message(
      {this.isFromMe,
      this.senderId,
      this.receiverId,
      this.createdDate,
      this.message});

  Message.fromMap(Map<String, dynamic> map)
      : senderId = map['senderId'],
        receiverId = map['receiverId'],
        isFromMe = map['isFromMe'],
        createdDate = map['createdDate'],
        message = map['message'];

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'isFromMe': isFromMe,
      'createdDate': createdDate ?? FieldValue.serverTimestamp(),
      'message': message,
    };
  }

  @override
  String toString() {
    return 'Message{senderId: $senderId,receiverId: $receiverId,isFromMe: $isFromMe,createdDate: $createdDate,message: $message}';
  }
}
