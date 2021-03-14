import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/models/user.dart';
import 'package:thepeti/screens/profilePhoto.dart';
import 'package:thepeti/services/authorizationService.dart';
import 'package:thepeti/services/fireStoreService.dart';

class EditProfile extends StatefulWidget {
  final User profile;
  const EditProfile({Key key, this.profile}) : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var formKey = GlobalKey<FormState>();
  String firstName, lastName, bio;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          userInformation(),
        ],
      ),
    );
  }

  userInformation() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 50, 25, 20),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(widget.profile.imageURL),
                  radius: 32,
                ),
                SizedBox(
                  width: 25.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfilePhoto()));
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
              initialValue: widget.profile.firstName,
              autocorrect: true,
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
              initialValue: widget.profile.lastName,
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
              initialValue: widget.profile.bio,
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
            SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_circle_outline),
                SizedBox(
                  width: 15.0,
                ),
                InkWell(
                  onTap: () {},
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
            Container(
              height: 60,
              width: 400,
              child: ElevatedButton(
                child: Text("KAYDET"),
                onPressed: () => save(),
                style: ElevatedButton.styleFrom(
                  primary: primaryColor,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  save() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      String activeUserId =
          Provider.of<AuthorizationService>(context, listen: false)
              .activeUserId;
      FireStoreService().editUser(
        userId: activeUserId,
        firstName: firstName,
        lastName: lastName,
        bio: bio,
      );
    }
  }
}