import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User {
  String userId;
  String firstName;
  String lastName;
  String email;
  DateTime birthDate;
  String password;
  DateTime createdDate;
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
      // birthDate: doc["birthDate"],
      password: doc["password"],
      // createdDate: doc["createdDate"],
      imageURL: doc["imageURL"],
      bio: doc["bio"],
    );
  }

  // factory User.createdFromDocument(DocumentSnapshot doc) {
  //   return User(
  //     firstName: doc["firstName"],
  //     imageURL: doc["imageURL"],
  //     // birthDate: doc["birthDate"],
  //     userId: doc.documentID,
  //     lastName: doc["lastName"],
  //     email: doc["email"],
  //     password: doc["password"],
  //     // createdDate: doc["createdDate"],
  //     bio: doc["bio"],
  //   );
  // }

  factory User.createFromFirebase(FirebaseUser user) {
    return User(
      userId: user.uid,
      firstName: user.displayName,
      email: user.email,
      imageURL: user.photoUrl,
    );
  }
}

// User.fromJson(Map<String, dynamic> json) {
//   userId = json['userId'];
//   firstName = json['firstName'];
//   lastName = json['lastName'];
//   email = json['email'];
//   gsmNumber = json['gsmNumber'];
//   birthDate  json['birthDate'];
//   password = json['password'];
//   createdDate = json['createdDate'];
//   imageURL = json['imageURL'];
//   bio = json['bio'];
// }

// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['userId'] = this.userId;
//   data['firstName'] = this.firstName;
//   data['lastName'] = this.lastName;
//   data['email'] = this.email;
//   data['gsmNumber'] = this.gsmNumber;
//   data['birthDate'] = this.birthDate;
//   data['password'] = this.password;
//   data['createdDate'] = this.createdDate;
//   data['imageURL'] = this.imageURL;
//   data['bio'] = this.bio;
//   return data;
// }
