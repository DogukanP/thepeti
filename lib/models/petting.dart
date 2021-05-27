import 'package:cloud_firestore/cloud_firestore.dart';

class Petting {
  final String pettingId;
  final String userId;
  final int price;
  final Timestamp pettingDate;
  final String district;
  final String city;
  final String note;
  final bool confirm;

  Petting(
      {this.pettingId,
      this.userId,
      this.price,
      this.pettingDate,
      this.district,
      this.city,
      this.note,
      this.confirm});

  factory Petting.createFromDocument(DocumentSnapshot doc) {
    var docData = doc.data;
    return Petting(
      pettingId: doc.documentID,
      userId: docData["userId"],
      price: docData["price"],
      city: docData["city"],
      district: docData["district"],
      pettingDate: docData["pettingDate"],
      note: docData["note"],
      confirm: docData["confirm"],
    );
  }
}
