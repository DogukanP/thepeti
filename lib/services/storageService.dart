import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  StorageReference storage = FirebaseStorage.instance.ref();
  String imageId;

  Future<String> uploadProfilePhoto(File imageFile) async {
    imageId = Uuid().v4();
    StorageUploadTask uploadManager =
        storage.child("images/profile/profile_$imageId.jpg").putFile(imageFile);
    StorageTaskSnapshot snapshot = await uploadManager.onComplete;
    String uploadPhotoUrl = await snapshot.ref.getDownloadURL();
    return uploadPhotoUrl;
  }

  Future<String> uploadPetiPhoto(File imageFile) async {
    imageId = Uuid().v4();
    StorageUploadTask uploadManager =
        storage.child("images/peti/peti_$imageId.jpg").putFile(imageFile);
    StorageTaskSnapshot snapshot = await uploadManager.onComplete;
    String uploadPhotoUrl = await snapshot.ref.getDownloadURL();
    return uploadPhotoUrl;
  }

  void deletePetiPhoto(String petiImageUrl) {
    RegExp search = RegExp(r"peti_.+\.jpg");
    var match = search.firstMatch(petiImageUrl);
    String fileName = match[0];
    if (fileName != null) {
      storage.child("images/peti/$fileName").delete();
    }
  }
}
