import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/screens/profilePhoto.dart';
import 'package:thepeti/services/authorizationService.dart';
import 'package:thepeti/services/fireStoreService.dart';
import 'package:thepeti/services/storageService.dart';

class AddPeti extends StatefulWidget {
  @override
  _AddPetiState createState() => _AddPetiState();
}

class _AddPetiState extends State<AddPeti> {
  File file;
  String name, image, genus;
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 110.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage:
                            file == null ? NetworkImage("") : FileImage(file),
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
                      name = value.toUpperCase();
                    },
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  TextFormField(
                    autocorrect: true,
                    decoration: InputDecoration(
                        labelText: "CİNS",
                        labelStyle: inputText,
                        focusedBorder: inputBorder),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "CİNS ALANI BOŞ BIRAKILAMAZ!";
                      } else if (value.trim().length < 2) {
                        return "CİNS 2 KARAKTERDEN AZ OLAMAZ!";
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
                  Container(
                    height: 60,
                    width: 400,
                    child: ElevatedButton(
                      child: Text("KAYDET"),
                      onPressed: () => createPeti(),
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
          ),
        ],
      ),
    );
  }

  createPeti() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (!loading) {
        setState(() {
          loading = true;
        });
        if (file != null) {
          image = await StorageService().uploadPetiPhoto(file);
        }
        String activeUserId =
            Provider.of<AuthorizationService>(context, listen: false)
                .activeUserId;
        await FireStoreService().createPeti(
            genus: genus, imageURL: image, name: name, ownerId: activeUserId);

        setState(() {
          loading = false;
          file = null;
        });
      }
    }
    Navigator.pop(context);
  }
}
