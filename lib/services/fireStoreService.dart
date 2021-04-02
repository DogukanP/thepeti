import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thepeti/models/peti.dart';
import 'package:thepeti/models/petting.dart';
import 'package:thepeti/models/user.dart';
import 'package:thepeti/services/storageService.dart';

class FireStoreService {
  final Firestore firestore = Firestore.instance;
  final Timestamp time = Timestamp.now();

  Future<void> createUser(
      {userId,
      email,
      password = "",
      firstName,
      lastName = "",
      birthDate,
      imageURL = ""}) async {
    await firestore.collection("User").document(userId).setData({
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "birthDate": birthDate,
      "bio": "",
      "imageURL": imageURL,
      "createdDate": time,
    });
  }

  Future<User> getUser(userId) async {
    DocumentSnapshot doc =
        await firestore.collection("User").document(userId).get();
    if (doc.exists) {
      User user = User.createdFromDocument(doc);
      return user;
    }
    return null;
  }

  void editUser({
    String userId,
    String firstName,
    String lastName,
    String bio,
    String imageURL = "",
  }) {
    firestore.collection("User").document(userId).updateData({
      "firstName": firstName,
      "lastName": lastName,
      "bio": bio,
      "imageURL": imageURL,
    });
  }

  // Future<void> createPetting(
  //     {userId, pettingDate, price, city, district, note}) async {
  //   await firestore
  //       .collection("Petting")
  //       .document(userId)
  //       .collection("UserPetting")
  //       .add({
  //     "userId": userId,
  //     "price": price,
  //     "city": city,
  //     "district": district,
  //     "pettingDate": pettingDate,
  //     "note": note,
  //     "createdDate": time,
  //   });
  // }
  Future<void> createPetting(
      {userId, pettingDate, price, city, district, note}) async {
    await firestore.collection("Petting").add({
      "userId": userId,
      "price": price,
      "city": city,
      "district": district,
      "pettingDate": pettingDate,
      "note": note,
      "createdDate": time,
    });
  }

  // Future<List<Petting>> getPetting(userId) async {
  //   QuerySnapshot snapshot = await firestore
  //       .collection("Petting")
  //       .document(userId)
  //       .collection("UserPetting")
  //       .orderBy("pettingDate", descending: false)
  //       .getDocuments();
  //   List<Petting> pettings = snapshot.documents
  //       .map((doc) => Petting.createFromDocument(doc))
  //       .toList();
  //   return pettings;
  // }
  //
  Future<List<Petting>> getPetting(userId) async {
    QuerySnapshot snapshot = await firestore
        .collection("Petting")
        .where("userId", isEqualTo: userId)
        .orderBy("pettingDate", descending: false)
        .getDocuments();
    List<Petting> pettings = snapshot.documents
        .map((doc) => Petting.createFromDocument(doc))
        .toList();
    return pettings;
  }

  // Future<List<Petting>> getPettingsForSearchKeeper(city) async {
  //   QuerySnapshot snapshot = await firestore
  //       .collection("Petting")
  //       .where("city", isEqualTo: city)
  //       .where("price", isEqualTo: "35")
  //       .getDocuments();
  //   List<Petting> pettings = snapshot.documents
  //       .map((doc) => Petting.createFromDocument(doc))
  //       .toList();
  //   return pettings;
  // }

  Future<void> createPeti({imageURL = "", name, genus, ownerId}) async {
    await firestore
        .collection("Peti")
        .document(ownerId)
        .collection("UserPeti")
        .add({
      "imageURL": imageURL,
      "name": name,
      "genus": genus,
      "ownerId": ownerId,
      "createdDate": time,
    });
  }

  Future<List<Peti>> getPetis(userId) async {
    QuerySnapshot snapshot = await firestore
        .collection("Peti")
        .document(userId)
        .collection("UserPeti")
        .getDocuments();
    List<Peti> petis =
        snapshot.documents.map((doc) => Peti.createFromDocument(doc)).toList();
    return petis;
  }

  Future<Peti> getPeti(userId, petiId) async {
    DocumentSnapshot doc = await firestore
        .collection("Peti")
        .document(userId)
        .collection("UserPeti")
        .document(petiId)
        .get();
    Peti peti = Peti.createFromDocument(doc);
    return peti;
  }

  void editPeti({
    String ownerId,
    String name,
    String genus,
    String imageURL = "",
    String petiId,
  }) {
    firestore
        .collection("Peti")
        .document(ownerId)
        .collection("UserPeti")
        .document(petiId)
        .updateData({
      "name": name,
      "genus": genus,
      "imageURL": imageURL,
    });
  }

  // ignore: missing_return
  Future<void> deletePeti({String activeUserId, Peti peti}) {
    firestore
        .collection("Peti")
        .document(activeUserId)
        .collection("UserPeti")
        .document(peti.petiId)
        .get()
        .then((DocumentSnapshot doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });

    StorageService().deletePetiPhoto(peti.imageURL);
  }
}

// requestId , pettingId , petiId, userId, createdDate
