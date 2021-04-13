import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  String requestId;
  String petiId;
  String ownerId;
  bool confirm;
  String pettingId;

  Request(
      {this.requestId,
      this.petiId,
      this.ownerId,
      this.confirm,
      this.pettingId});

  factory Request.createFromDocument(DocumentSnapshot doc) {
    var docData = doc.data;
    return Request(
      requestId: doc.documentID,
      petiId: docData["petiId"],
      ownerId: docData["ownerId"],
      confirm: docData["confirm"],
      pettingId: docData["pettingId"],
    );
  }
}
