import 'package:cloud_firestore/cloud_firestore.dart';

class Peti {
  String petiId;
  String name;
  String genus;
  String imageURL;
  String ownerId;

  Peti({this.petiId, this.name, this.genus, this.imageURL, this.ownerId});

  factory Peti.createFromDocument(DocumentSnapshot doc) {
    var docData = doc.data;
    return Peti(
      petiId: doc.documentID,
      ownerId: docData["ownerId"],
      name: docData["name"],
      genus: docData["genus"],
      imageURL: docData["imageURL"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "ownerId": ownerId,
      "name": name,
      "genus": genus,
      "imageURL": imageURL
    };
  }

  Peti.fromMap(Map<String, dynamic> map)
      : ownerId = map["ownerId"],
        name = map["name"],
        genus = map["genus"],
        imageURL = map["imageURL"];

  @override
  String toString() {
    return 'Peti{ownerId : $ownerId,"name" $name, "genus" $genus, "imageURL" $imageURL}';
  }
}
