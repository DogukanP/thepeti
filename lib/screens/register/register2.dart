import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/models/user.dart';
import 'package:thepeti/services/authorizationService.dart';
import 'package:thepeti/services/fireStoreService.dart';
import 'package:thepeti/widgets/calculateAge.dart';

class Register2 extends StatefulWidget {
  final User user;
  const Register2({Key key, this.user}) : super(key: key);
  @override
  _Register2State createState() => _Register2State();
}

class _Register2State extends State<Register2> {
  bool loading = false;
  DateTime birthDate = DateTime.now();
  TextEditingController birthDateController = new TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomPadding: false,
      body: ListView(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        children: [
          Container(
            padding: EdgeInsets.only(top: 60.0),
            child: Text(
              "KAYDOL",
              style: text80,
            ),
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Column(
                    children: [
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
                          widget.user.firstName = value;
                        },
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      TextFormField(
                        autocorrect: true,
                        decoration: InputDecoration(
                            labelText: "SOYİSİM",
                            labelStyle: inputText,
                            focusedBorder: inputBorder),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "SOYİSİM ALANI BOŞ BIRAKILAMAZ!";
                          } else if (value.trim().length < 2) {
                            return "SOYİSİM 2 KARAKTERDEN AZ OLAMAZ!";
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          widget.user.lastName = value;
                        },
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      TextFormField(
                        controller: birthDateController,
                        readOnly: true,
                        onTap: () {
                          birthDatePicker(context);
                        },
                        decoration: InputDecoration(
                          labelText: "DOĞUM TARİHİ",
                          labelStyle: inputText,
                          focusedBorder: inputBorder,
                        ),
                        validator: (value) {
                          value = calculateAge(birthDate).toString();
                          if (value.isEmpty) {
                            return "BİR TARİH SEÇİNİZ";
                          } else if (int.parse(value) < 18) {
                            return "18 YAŞINDAN BÜYÜK OLMALISINIZ!";
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          value = birthDate.toString();
                          widget.user.birthDate =
                              Timestamp.fromDate(DateTime.parse(value));
                        },
                      ),
                      SizedBox(
                        height: 90.0,
                      ),
                      Container(
                        height: 60,
                        width: 400,
                        child: ElevatedButton(
                          child: Text("KAYDOL"),
                          onPressed: () => register(),
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
                        height: 50.0,
                      ),
                      loading
                          ? LinearProgressIndicator(
                              backgroundColor: Colors.white,
                            )
                          : SizedBox(
                              height: 0.0,
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

  void register() async {
    final authorizationService =
        Provider.of<AuthorizationService>(context, listen: false);
    var formState = formKey.currentState;
    if (formState.validate()) {
      formState.save();
      setState(() {
        loading = true;
      });
      try {
        User user = await authorizationService.registerByMail(
            widget.user.email, widget.user.password);
        if (user != null) {
          FireStoreService().createUser(
              userId: user.userId,
              email: widget.user.email,
              password: widget.user.password,
              firstName: widget.user.firstName,
              lastName: widget.user.lastName,
              birthDate: widget.user.birthDate);
        }
        Navigator.popUntil(
            context, (Route<dynamic> predicate) => predicate.isFirst);
      } catch (e) {
        setState(() {
          loading = false;
          showError(errorCode: e.code);
        });
      }
    }
  }

  Future<Null> birthDatePicker(context) async {
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: birthDate,
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
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

    if (picked != null && picked != birthDate) {
      setState(() {
        birthDate = picked;
        birthDateController.value =
            TextEditingValue(text: formatter.format(picked));
      });
    }
  }

  showError({errorCode}) {
    String errorMessage;
    if (errorCode == "ERROR_INVALID_EMAIL") {
      errorMessage = "Girdiğiniz mail adresi geçersizdir";
    } else if (errorCode == "ERROR_EMAIL_ALREADY_IN_USE") {
      errorMessage = "Girdiğiniz mail adresi kayıtlıdır";
    } else if (errorCode == "ERROR_WEAK_PASSWORD") {
      errorMessage = "Daha zor bir şifre tercih edin";
    }

    var snackBar = SnackBar(
      backgroundColor: primaryColor,
      content: Text(errorMessage),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
