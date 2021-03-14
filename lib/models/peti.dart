import 'package:cloud_firestore/cloud_firestore.dart';

class Peti {
  String petiId;
  String name;
  String genus;
  Timestamp createdDate;
  String imageURL;
  String ownerId;

  Peti(
      {this.petiId,
      this.name,
      this.genus,
      this.createdDate,
      this.imageURL,
      this.ownerId});
}
