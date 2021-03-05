import 'package:cloud_firestore/cloud_firestore.dart';

class Petting {
  String pettingId;
  String userId;
  int price;
  Timestamp pettingDate;
  String district;
  String city;
  String note;

  Petting(
      {this.pettingId,
      this.userId,
      this.price,
      this.pettingDate,
      this.district,
      this.city,
      this.note});

  factory Petting.createFromDocument(DocumentSnapshot doc) {
    return Petting(
      pettingId: doc.documentID,
      userId: doc["userId"],
      price: doc["price"],
      city: doc["city"],
      district: doc["district"],
      pettingDate: doc["pettingDate"],
      note: doc["pettingDate"],
    );
  }
}
