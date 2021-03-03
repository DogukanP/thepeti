import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thepeti/models/user.dart';

class FireStoreService {
  final Firestore firestore = Firestore.instance;
  final DateTime time = DateTime.now();

  Future<void> createUser(
      {userId,
      email,
      password = "",
      firstName,
      lastName = "",
      birthDate = "",
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
}
