import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/screens/profile.dart';
import 'package:thepeti/services/authorizationService.dart';
import 'package:thepeti/widgets/button.dart';

class SearchKeeper extends StatefulWidget {
  @override
  _SearchKeeperState createState() => _SearchKeeperState();
}

class _SearchKeeperState extends State<SearchKeeper> {
  String city;
  DateTime pettingDate;
  TextEditingController dateController = new TextEditingController();
  DateTime currentDate = DateTime.now();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BAKICI ARA",
          textAlign: TextAlign.start,
          style: textBlackC,
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              icon: Icon(Icons.mail_outline, color: Colors.black),
              onPressed: null),
          SizedBox(
            width: 5.0,
          ),
          IconButton(
            icon: Icon(
              Icons.account_circle,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Profile(
                          profileOwnerId: Provider.of<AuthorizationService>(
                                  context,
                                  listen: false)
                              .activeUserId,
                        )),
              );
            },
          ),
        ],
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
                        controller: dateController,
                        readOnly: true,
                        onTap: () {
                          datePicker(context);
                        },
                        decoration: InputDecoration(
                          labelText: "TARİH SEÇ",
                          labelStyle: inputText,
                          focusedBorder: inputBorder,
                        ),
                        validator: (value) {
                          value = currentDate.toString();
                          if (value.isEmpty) {
                            return "BİR TARİH SEÇİNİZ";
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          value = currentDate.toString();
                          pettingDate = DateTime.parse(value);
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
                          city = value.toUpperCase();
                        },
                      ),
                      SizedBox(
                        height: 80.0,
                      ),
                      Button(
                        buttonColor: primaryColor,
                        buttonFunction: () => next(),
                        buttonText: "ARA",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<Null> datePicker(context) async {
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData(
            primaryColor: primaryColor,
            accentColor: primaryColor,
          ),
          child: child,
        );
      },
    );

    if (picked != null && picked != currentDate) {
      setState(() {
        currentDate = picked;
        dateController.value = TextEditingValue(text: formatter.format(picked));
      });
    }
  }

  next() {}
}
