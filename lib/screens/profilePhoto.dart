import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/widgets/button.dart';

class ProfilePhoto extends StatefulWidget {
  @override
  _ProfilePhotoState createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  File file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 100.0),
        child: Column(
          children: [
            Text(
              "FOTOĞRAFTA YÜZÜNÜN NET GÖRÜNMESİ GEREKİR BUNU UNUTMA",
              style: text50,
            ),
            SizedBox(height: 40),
            Button(
              buttonColor: primaryColor,
              buttonFunction: () => takePhoto(),
              buttonText: "FOTOĞRAF ÇEK",
            ),
            SizedBox(height: 10),
            Container(
              height: 60.0,
              width: 400.0,
              child: GestureDetector(
                onTap: () {
                  choosePhoto();
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: primaryColor,
                      style: BorderStyle.solid,
                      width: 1.8,
                    ),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text(
                          "FOTOĞRAF SEÇ",
                          style: textPrimaryC,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  takePhoto() async {
    var image = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxHeight: 600,
        maxWidth: 800,
        imageQuality: 80);
    setState(() {
      file = File(image.path);
    });
    Navigator.pop(context, file);
  }

  choosePhoto() async {
    var image = await ImagePicker().getImage(
        source: ImageSource.gallery,
        maxHeight: 600,
        maxWidth: 800,
        imageQuality: 80);
    setState(() {
      file = File(image.path);
    });

    Navigator.pop(context, file);
  }
}
