import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thepeti/models/petting.dart';
import 'package:thepeti/models/user.dart';

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
    // String imageURL = "",
  }) {
    firestore.collection("User").document(userId).updateData({
      "firstName": firstName,
      "lastName": lastName,
      "bio": bio,
      // "imageURL": imageURL,
    });
  }

  Future<void> createPetting(
      {userId, pettingDate, price, city, district, note}) async {
    await firestore
        .collection("Petting")
        .document(userId)
        .collection("UserPetting")
        .add({
      "userId": userId,
      "price": price,
      "city": city,
      "district": district,
      "pettingDate": pettingDate,
      "note": note,
      "createdDate": time,
    });
  }

  Future<List<Petting>> getPetting(userId) async {
    QuerySnapshot snapshot = await firestore
        .collection("Petting")
        .document(userId)
        .collection("UserPetting")
        .orderBy("pettingDate", descending: false)
        .getDocuments();
    List<Petting> pettings = snapshot.documents
        .map((doc) => Petting.createFromDocument(doc))
        .toList();
    return pettings;
  }
}
