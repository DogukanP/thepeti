import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/screens/beKeeper/beKeeper2.dart';
import 'package:thepeti/screens/chat/chatList.dart';
import 'package:thepeti/screens/profile/profile.dart';
import 'package:thepeti/services/authorizationService.dart';
import 'package:thepeti/widgets/button.dart';

class BeKeeper extends StatefulWidget {
  @override
  _BeKeeperState createState() => _BeKeeperState();
}

class _BeKeeperState extends State<BeKeeper> {
  int price;
  DateTime pettingDate;
  TextEditingController dateController = new TextEditingController();
  DateTime currentDate = DateTime.now();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BAKICI OL",
          style: textBlackC,
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.mail_outline, color: Colors.black),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ChatList(),
              ),
            ),
          ),
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
                      profileOwnerId: Provider.of<AuthorizationService>(context,
                              listen: false)
                          .activeUserId,
                    ),
                  ),
                );
              })
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
                          keyboardType: TextInputType.number,
                          autocorrect: true,
                          decoration: InputDecoration(
                              labelText: "ÜCRET GİR",
                              labelStyle: inputText,
                              focusedBorder: inputBorder),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "ÜCRET ALANI BOŞ BIRAKILAMAZ!";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            price = int.parse(value);
                          },
                        ),
                        SizedBox(
                          height: 80.0,
                        ),
                        Button(
                          buttonColor: primaryColor,
                          buttonFunction: () => next(),
                          buttonText: "DEVAM ET",
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

  void next() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => BeKeeper2(
            pettingDate: pettingDate,
            price: price,
          ),
        ),
      );
    }
  }
}
