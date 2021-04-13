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

  Future<Petting> getPetting(pettingId) async {
    DocumentSnapshot doc =
        await firestore.collection("Petting").document(pettingId).get();
    Petting petting = Petting.createFromDocument(doc);
    return petting;
  }

  Future<List<Petting>> getPettings(userId) async {
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

  void deletePetting(pettingId) {
    firestore
        .collection("Petting")
        .document(pettingId)
        .get()
        .then((DocumentSnapshot doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
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

  Stream<QuerySnapshot> getPetisLive(userId) {
    return firestore
        .collection("Peti")
        .where("ownerId", isEqualTo: userId)
        .snapshots();
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

  Future<void> createComplaint({senderId, receiverId, note}) async {
    await firestore.collection("Complaint").add({
      "senderId": senderId,
      "receiverId": receiverId,
      "note": note,
      "createdDate": time
    });
  }

  Future<void> createRequest({
    userId,
    pettingId,
    petiId,
  }) async {
    await firestore.collection("Request").add({
      "ownerId": userId,
      "petiId": petiId,
      "pettingId": pettingId,
      "confirm": false,
    });
  }

  void editRequest(reqId) {
    firestore
        .collection("Request")
        .document(reqId)
        .updateData({"confirm": true});
  }

  void deleteRequest(reqId) {
    firestore
        .collection("Request")
        .document(reqId)
        .get()
        .then((DocumentSnapshot doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }

  deleteRequestNoReqId(pettingId, ownerId) async {
    QuerySnapshot doc = await firestore
        .collection("Request")
        .where("pettingId", isEqualTo: pettingId)
        .where("ownerId", isEqualTo: ownerId)
        .getDocuments();
    List<Request> requests =
        doc.documents.map((e) => Request.createFromDocument(e)).toList();
    requests.forEach((element) {
      deleteRequest(element.requestId);
    });
  }

  Future<bool> reqControl(pettingId, ownerId) async {
    QuerySnapshot doc = await firestore
        .collection("Request")
        .where("pettingId", isEqualTo: pettingId)
        .where("ownerId", isEqualTo: ownerId)
        .getDocuments();
    if (doc.documents.isEmpty) {
      return false;
    }
    return true;
  }

  Future<List<Request>> getRequest(ownerId) async {
    QuerySnapshot doc = await firestore
        .collection("Request")
        .where("ownerId", isEqualTo: ownerId)
        .getDocuments();
    List<Request> requests =
        doc.documents.map((e) => Request.createFromDocument(e)).toList();
    return requests;
  }

  Stream<QuerySnapshot> getNotConfirmRequest(String id) {
    return firestore
        .collection("Request")
        .where("pettingId", isEqualTo: id)
        .where("confirm", isEqualTo: false)
        .snapshots();
  }

  Stream<QuerySnapshot> getConfirmRequest(String id) {
    return firestore
        .collection("Request")
        .where("pettingId", isEqualTo: id)
        .where("confirm", isEqualTo: true)
        .snapshots();
  }
}
