import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/screens/beKeeper/beKeeper3.dart';

// ignore: must_be_immutable
class BeKeeper2 extends StatefulWidget {
  DateTime pettingDate;
  int price;
  BeKeeper2({this.pettingDate, this.price});
  @override
  _BeKeeper2State createState() => _BeKeeper2State();
}

class _BeKeeper2State extends State<BeKeeper2> {
  String district, city;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          formatter.format(widget.pettingDate).toString(),
          style: textBlackC,
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20.0, 130.0, 20.0, 0),
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "İLÇE",
                            labelStyle: inputText,
                            focusedBorder: inputBorder),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "İLÇE ALANI BOŞ BIRAKILAMAZ!";
                          } else if (value.trim().length < 2) {
                            return "İLÇE 2 KARAKTERDEN AZ OLAMAZ!";
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          district = value;
                        },
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: "İL",
                            labelStyle: inputText,
                            focusedBorder: inputBorder),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "İL ALANI BOŞ BIRAKILAMAZ!";
                          } else if (value.trim().length < 2) {
                            return "İL 2 KARAKTERDEN AZ OLAMAZ!";
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          city = value;
                        },
                      ),
                      SizedBox(
                        height: 90.0,
                      ),
                      Container(
                        height: 60,
                        width: 400,
                        child: ElevatedButton(
                          child: Text("DEVAM ET"),
                          onPressed: () => next(),
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
              ],
            ),
          )
        ],
      ),
    );
  }

  next() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => BeKeeper3(
                  price: widget.price,
                  city: city,
                  district: district,
                  pettingDate: widget.pettingDate,
                )),
      );
    }
  }
}
