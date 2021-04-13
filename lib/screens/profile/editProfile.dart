import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/models/peti.dart';
import 'package:thepeti/models/user.dart';
import 'package:thepeti/screens/peti/addPeti.dart';
import 'package:thepeti/screens/profilePhoto.dart';
import 'package:thepeti/services/authorizationService.dart';
import 'package:thepeti/services/fireStoreService.dart';
import 'package:thepeti/services/storageService.dart';
import 'package:thepeti/widgets/button.dart';
import 'package:thepeti/widgets/petiCard.dart';

class EditProfile extends StatefulWidget {
  final User profile;
  const EditProfile({Key key, this.profile}) : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File file;
  var formKey = GlobalKey<FormState>();
  String firstName, lastName, bio;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          userInformation(),
          petis(),
          end(),
        ],
      ),
    );
  }

  userInformation() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 50, 25, 0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: file == null
                      ? NetworkImage(widget.profile.imageURL)
                      : FileImage(file),
                  radius: 32,
                ),
                SizedBox(
                  width: 25.0,
                ),
                InkWell(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePhoto(),
                      ),
                    );
                    setState(() {
                      file = result as File;
                    });
                  },
                  child: Text(
                    "FOTOĞRAF EKLE / DEĞİŞTİR",
                    style: textPrimaryC,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
            TextFormField(
              initialValue: widget.profile.firstName.toUpperCase(),
              decoration: InputDecoration(
                  labelText: "İSİM",
                  labelStyle: inputText,
                  focusedBorder: inputBorder),
              validator: (value) {
                if (value.isEmpty) {
                  return "İSİM ALANI BOŞ BIRAKILAMAZ!";
                } else if (value.trim().length < 2) {
                  return "İSİM 2 KARAKTERDEN AZ OLAMAZ!";
                }
                return null;
              },
              onSaved: (String value) {
                firstName = value;
              },
            ),
            SizedBox(
              height: 50.0,
            ),
            TextFormField(
              initialValue: widget.profile.lastName.toUpperCase(),
              autocorrect: true,
              decoration: InputDecoration(
                  labelText: "SOYİSİM",
                  labelStyle: inputText,
                  focusedBorder: inputBorder),
              validator: (value) {
                if (value.isEmpty) {
                  return "SOYİSİM ALANI BOŞ BIRAKILAMAZ!";
                } else if (value.trim().length < 2) {
                  return "SOYİSİM 2 KARAKTERDEN AZ OLAMAZ!";
                }
                return null;
              },
              onSaved: (String value) {
                lastName = value;
              },
            ),
            SizedBox(
              height: 50.0,
            ),
            TextFormField(
              initialValue: widget.profile.bio.toUpperCase(),
              autocorrect: true,
              maxLength: 300,
              maxLines: 15,
              minLines: 1,
              decoration: InputDecoration(
                  labelText: "BİO",
                  labelStyle: inputText,
                  focusedBorder: inputBorder),
              validator: (value) {
                if (value.isEmpty) {
                  return "BİO ALANI BOŞ BIRAKILAMAZ!";
                } else if (value.length < 20) {
                  return "BİO ALANI 20 KARAKTERDEN AZ OLAMAZ!";
                }
                return null;
              },
              onSaved: (String value) {
                bio = value;
              },
            ),
            SizedBox(
              height: 50.0,
            ),
            InkWell(
              onTap: () {},
              child: Text(
                "ŞİFRENİ DEĞİŞTİR",
                style: textPrimaryC,
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            Container(
              height: 1.3,
              color: Colors.grey[500],
            ),
          ],
        ),
      ),
    );
  }

  end() {
    return Padding(
      padding:
          EdgeInsets.only(top: 50.0, left: 25.0, right: 25.0, bottom: 50.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Icon(Icons.add_circle_outline),
              SizedBox(
                width: 15.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddPeti()));
                },
                child: Text(
                  "PETİ EKLE",
                  style: textPrimaryC,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50.0,
          ),
          Container(
            height: 1.3,
            color: Colors.grey[500],
          ),
          SizedBox(
            height: 50.0,
          ),
          InkWell(
            onTap: () {},
            child: Text(
              "YARDIM",
              style: textPrimaryC,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          InkWell(
            onTap: () {},
            child: Text(
              "S.S.S.",
              style: textPrimaryC,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          InkWell(
            onTap: () {},
            child: Text(
              "ŞARTLAR VE ONAYLAR",
              style: textPrimaryC,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Button(
            buttonColor: primaryColor,
            buttonFunction: () => save(),
            buttonText: "KAYDET",
          ),
        ],
      ),
    );
  }

  petis() {
    return StreamBuilder<QuerySnapshot>(
      stream: FireStoreService().getPetisLive(widget.profile.userId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text("data yok");
        }
        return ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) {
            Peti peti = Peti.createFromDocument(snapshot.data.documents[index]);
            return PetiCard(
              peti: peti,
            );
          },
        );
      },
    );
  }

  save() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      String profilePhotoUrl;
      if (file == null) {
        profilePhotoUrl = widget.profile.imageURL;
      } else {
        profilePhotoUrl = await StorageService().uploadProfilePhoto(file);
      }
      String activeUserId =
          Provider.of<AuthorizationService>(context, listen: false)
              .activeUserId;
      FireStoreService().editUser(
        userId: activeUserId,
        firstName: firstName,
        lastName: lastName,
        bio: bio,
        imageURL: profilePhotoUrl,
      );
    }
    Navigator.pop(context);
  }
}
