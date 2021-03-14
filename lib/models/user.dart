import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User {
  String userId;
  String firstName;
  String lastName;
  String email;
  Timestamp birthDate;
  String password;
  Timestamp createdDate;
  String imageURL;
  String bio;

  User(
      {this.userId,
      this.firstName,
      this.lastName,
      this.email,
      this.birthDate,
      this.password,
      this.createdDate,
      this.imageURL,
      this.bio});

  factory User.createdFromDocument(DocumentSnapshot doc) {
    return User(
      userId: doc.documentID,
      firstName: doc["firstName"],
      lastName: doc["lastName"],
      email: doc["email"],
      birthDate: doc["birthDate"],
      password: doc["password"],
      createdDate: doc["createdDate"],
      imageURL: doc["imageURL"],
      bio: doc["bio"],
    );
  }

  factory User.createFromFirebase(FirebaseUser user) {
    return User(
      userId: user.uid,
      firstName: user.displayName,
      email: user.email,
      imageURL: user.photoUrl,
    );
  }
}
