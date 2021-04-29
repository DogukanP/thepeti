import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/models/peti.dart';
import 'package:thepeti/screens/chat/chatList.dart';
import 'package:thepeti/screens/profile/profile.dart';
import 'package:thepeti/screens/searchKeeper/searchKeeper2.dart';
import 'package:thepeti/services/authorizationService.dart';
import 'package:thepeti/services/fireStoreService.dart';
import 'package:thepeti/widgets/button.dart';

class SearchKeeper extends StatefulWidget {
  @override
  _SearchKeeperState createState() => _SearchKeeperState();
}

class _SearchKeeperState extends State<SearchKeeper> {
  String city;
  DateTime requestDate;
  TextEditingController dateController = new TextEditingController();
  DateTime currentDate = DateTime.now();
  final formKey = GlobalKey<FormState>();
  List<Peti> petiList = [];
  int selected = 0;

  getPetis() async {
    String activeUserId =
        Provider.of<AuthorizationService>(context, listen: false).activeUserId;
    List<Peti> petis = await FireStoreService().getPetis(activeUserId);
    setState(() {
      petiList = petis;
    });
  }

  @override
  void initState() {
    super.initState();
    getPetis();
  }

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
        padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0),
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
                          requestDate = DateTime.parse(value);
                        },
                      ),
                      SizedBox(
                        height: 40.0,
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
                        height: 50.0,
                      ),
                      Text(
                        "PETİNİ SEÇ",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.grey[500],
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Divider(
                        height: 25.0,
                        color: Colors.grey[600],
                        thickness: 1.0,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      radio(),
                      SizedBox(
                        height: 50.0,
                      ),
                      Button(
                        buttonColor: primaryColor,
                        buttonFunction: () => next(),
                        buttonText: "ARA",
                      ),
                      SizedBox(
                        height: 50.0,
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

  radio() {
    return Column(
      children: [
        for (int i = 0; i < petiList.length; i++)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Radio(
                  value: i,
                  groupValue: selected,
                  activeColor: primaryColor,
                  onChanged: (val) {
                    setState(() {
                      selected = val;
                    });
                  },
                ),
                SizedBox(
                  width: 30.0,
                ),
                CircleAvatar(
                  radius: 28.0,
                  backgroundColor: Colors.grey,
                  backgroundImage: petiList[i].imageURL.isNotEmpty
                      ? NetworkImage(petiList[i].imageURL)
                      : AssetImage("assets/profile_photo.png"),
                ),
                SizedBox(
                  width: 30.0,
                ),
                Text(
                  petiList[i].name,
                  style: text18,
                ),
              ],
            ),
          ),
      ],
    );
  }

  next() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (petiList.length < 1) {
        final snackBar = SnackBar(
          content: Text("BU İŞLEM İÇİN BİR PETİN OLMALI"),
          backgroundColor: primaryColor,
        );
        Scaffold.of(context).showSnackBar(snackBar);
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => SearchKeeper2(
              city: city,
              requestDate: requestDate,
              peti: petiList[selected],
            ),
          ),
        );
      }
    }
  }
}
