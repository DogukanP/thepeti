import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thepeti/models/peti.dart';
import 'package:thepeti/models/petting.dart';
import 'package:thepeti/models/request.dart';
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

  Future<List<Petting>> getPettingforSearch(city, timestamp) async {
    QuerySnapshot snapshot = await firestore
        .collection("Petting")
        .where("city", isEqualTo: city)
        .where("pettingDate", isEqualTo: timestamp)
        .orderBy("price")
        .getDocuments();
    List<Petting> pettings = snapshot.documents
        .map((doc) => Petting.createFromDocument(doc))
        .toList();
    return pettings;
  }

  Future<void> createPeti({imageURL = "", name, genus, ownerId}) async {
    await firestore.collection("Peti").add({
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
        .where("ownerId", isEqualTo: userId)
        .getDocuments();
    List<Peti> petis =
        snapshot.documents.map((doc) => Peti.createFromDocument(doc)).toList();
    return petis;
  }

  Future<Peti> getPeti(petiId) async {
    DocumentSnapshot doc =
        await firestore.collection("Peti").document(petiId).get();
    Peti peti = Peti.createFromDocument(doc);
    return peti;
  }

  void editPeti({
    String name,
    String genus,
    String imageURL = "",
    String petiId,
  }) {
    firestore.collection("Peti").document(petiId).updateData({
      "name": name,
      "genus": genus,
      "imageURL": imageURL,
    });
  }

  void deletePeti({Peti peti}) {
    firestore
        .collection("Peti")
        .document(peti.petiId)
        .get()
        .then((DocumentSnapshot doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });

    StorageService().deletePetiPhoto(peti.imageURL);
  }

  Future<void> createRequest({userId, pettingId, petiId}) async {
    await firestore
        .collection("Petting")
        .document(pettingId)
        .collection("Request")
        .add({
      "ownerId": userId,
      "petiId": petiId,
      "pettingId": pettingId,
    });
  }

  getRequest(pettingId, activeUserId) async {
    QuerySnapshot snapshot = await firestore
        .collection("Petting")
        .document(pettingId)
        .collection("Request")
        .where("ownerId", isEqualTo: activeUserId)
        .getDocuments();
    List<Request> request =
        snapshot.documents.map((e) => Request.createFromDocument(e)).toList();
    return request;
  }
}

/*


getRequest() async {
    String activeUserId =
        Provider.of<AuthorizationService>(context, listen: false).activeUserId;
    List<Request> request = await FireStoreService()
        .getRequest("JSdDdIiQ3zx1Ee65GaiP", activeUserId);
    setState(() {
      requestList = request;
    });
  }


*/
