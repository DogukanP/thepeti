import 'package:cloud_firestore/cloud_firestore.dart';

class Rating {
  String ratingId;
  String receiverId;
  String senderId;
  String comment;
  String rating;
  String pettingId;

  Rating(
      {this.ratingId,
      this.receiverId,
      this.senderId,
      this.comment,
      this.pettingId,
      this.rating});

  factory Rating.createFromDocument(DocumentSnapshot doc) {
    var docData = doc.data;
    return Rating(
      ratingId: doc.documentID,
      comment: docData["comment"],
      pettingId: docData["pettingId"],
      rating: docData["rating"],
      receiverId: docData["receiverId"],
      senderId: docData["senderId"],
    );
  }
}
