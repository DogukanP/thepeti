import 'package:flutter/material.dart';
import 'package:thepeti/constants.dart';

class EditPeti extends StatefulWidget {
  @override
  _EditPetiState createState() => _EditPetiState();
}

class _EditPetiState extends State<EditPeti> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 120.0),
          child: Form(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 50.0,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                InkWell(
                  onTap: () {},
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
                  onSaved: (String value) {},
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
                  onSaved: (String value) {},
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 60,
                  width: 400,
                  child: ElevatedButton(
                    child: Text("KAYDET"),
                    onPressed: () => null,
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  height: 60,
                  width: 400,
                  child: ElevatedButton(
                    child: Text("SİL"),
                    onPressed: () => null,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
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
    ));
  }
}
