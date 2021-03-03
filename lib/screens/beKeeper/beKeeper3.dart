import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thepeti/constants.dart';

// ignore: must_be_immutable
class BeKeeper3 extends StatefulWidget {
  int price;
  DateTime pettingDate;
  String district, city;
  BeKeeper3({this.pettingDate, this.price, this.district, this.city});
  @override
  _BeKeeper3State createState() => _BeKeeper3State();
}

class _BeKeeper3State extends State<BeKeeper3> {
  DateFormat formatter = DateFormat('dd/MM/yyyy');
  String note;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (formatter.format(widget.pettingDate)).toString(),
          style: textBlackC,
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20.0, 150.0, 20.0, 0),
        children: [
          Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        TextFormField(
                          autocorrect: true,
                          maxLength: 300,
                          maxLines: 15,
                          minLines: 1,
                          decoration: InputDecoration(
                              labelText: "İLAN YAZISI",
                              labelStyle: inputText,
                              focusedBorder: inputBorder),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "İLAN YAZISI BOŞ BIRAKILAMAZ!";
                            } else if (value.length < 40) {
                              return "İLAN YAZISI 40 KARAKTERDEN AZ OLAMAZ!";
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            note = value;
                          },
                        ),
                        SizedBox(
                          height: 90.0,
                        ),
                        Container(
                          height: 60,
                          width: 400,
                          child: ElevatedButton(
                            child: Text("İLAN VER"),
                            onPressed: () => finish(),
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
              ))
        ],
      ),
    );
  }

  finish() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      print(widget.city);
      print(widget.district);
      print(widget.pettingDate);
      print(widget.price);
      print(note);
    }
  }
}
