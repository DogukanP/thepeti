import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/screens/homeScreen.dart';
import 'package:thepeti/services/authorizationService.dart';
import 'package:thepeti/services/fireStoreService.dart';

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
  bool loading = false;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (formatter.format(widget.pettingDate)).toString(),
          textAlign: TextAlign.center,
          style: textBlackC,
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20.0, 150.0, 20.0, 0),
        children: [
          loading
              ? LinearProgressIndicator(
                  backgroundColor: primaryColor,
                )
              : SizedBox(
                  height: 0.0,
                ),
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

  finish() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (!loading) {
        setState(() {
          loading = true;
        });
        String activeUserId =
            Provider.of<AuthorizationService>(context, listen: false)
                .activeUserId;
        await FireStoreService().createPetting(
            city: widget.city,
            district: widget.district,
            note: note,
            pettingDate: widget.pettingDate,
            price: widget.price,
            userId: activeUserId);

        setState(() {
          loading = false;
        });

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
            (Route<dynamic> route) => route is HomeScreen);
      }
    }
  }
}
