import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/models/peti.dart';
import 'package:thepeti/screens/profilePhoto.dart';
import 'package:thepeti/services/authorizationService.dart';
import 'package:thepeti/services/fireStoreService.dart';
import 'package:thepeti/services/storageService.dart';
import 'package:thepeti/widgets/button.dart';

class EditPeti extends StatefulWidget {
  final Peti peti;

  const EditPeti({Key key, this.peti}) : super(key: key);
  @override
  _EditPetiState createState() => _EditPetiState();
}

class _EditPetiState extends State<EditPeti> {
  File file;
  var formKey = GlobalKey<FormState>();
  String name, genus;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 70.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage: (file == null)
                            ? NetworkImage(widget.peti.imageURL)
                            : FileImage(file),
                        radius: 50.0,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
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
                  SizedBox(
                    height: 40.0,
                  ),
                  TextFormField(
                    initialValue: widget.peti.name.toUpperCase(),
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
                      } else if (value.trim().length > 20) {
                        return "İSİM 20 KARAKTERDEN FAZLA OLAMAZ!";
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      name = value.toUpperCase();
                    },
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  TextFormField(
                    initialValue: widget.peti.genus.toUpperCase(),
                    decoration: InputDecoration(
                        labelText: "CİNS",
                        labelStyle: inputText,
                        focusedBorder: inputBorder),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "CİNS ALANI BOŞ BIRAKILAMAZ!";
                      } else if (value.trim().length < 2) {
                        return "CİNS 2 KARAKTERDEN AZ OLAMAZ!";
                      } else if (value.length > 20) {
                        return "CİNS 20 KARAKTERDEN FAZLA OLAMAZ!";
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      genus = value.toUpperCase();
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Button(
                    buttonColor: primaryColor,
                    buttonFunction: () => save(),
                    buttonText: "KAYDET",
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Button(
                    buttonColor: Colors.red,
                    buttonFunction: () => FireStoreService().deletePeti(
                        activeUserId: Provider.of<AuthorizationService>(context,
                                listen: false)
                            .activeUserId,
                        peti: widget.peti),
                    buttonText: "SİL",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  save() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      String profilePhotoUrl;
      if (file == null) {
        profilePhotoUrl = widget.peti.imageURL;
      } else {
        profilePhotoUrl = await StorageService().uploadPetiPhoto(file);
      }
      String activeUserId =
          Provider.of<AuthorizationService>(context, listen: false)
              .activeUserId;
      FireStoreService().editPeti(
          ownerId: activeUserId,
          name: name,
          genus: genus,
          imageURL: profilePhotoUrl,
          petiId: widget.peti.petiId);
    }
    Navigator.pop(context, true);
  }
}
