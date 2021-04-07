import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  String requestId;
  String petiId;
  String userId;

  Request({this.requestId, this.petiId, this.userId});

  factory Request.createFromDocument(DocumentSnapshot doc) {
    var docData = doc.data;
    return Request(
      requestId: doc.documentID,
      petiId: docData["petiId"],
      userId: docData["userId"],
    );
  }
}
