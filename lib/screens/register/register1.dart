import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/models/user.dart';
import 'package:thepeti/screens/register/register2.dart';
import 'package:thepeti/widgets/button.dart';
// import 'package:thepeti/services/authorizationService.dart';

class Register1 extends StatefulWidget {
  final User user;
  const Register1({Key key, this.user}) : super(key: key);
  @override
  _Register1State createState() => _Register1State();
}

class _Register1State extends State<Register1> {
  final formKey = GlobalKey<FormState>();
  TextEditingController passwordConroller = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                SizedBox(
                  height: 40.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "EMAIL",
                      labelStyle: inputText,
                      focusedBorder: inputBorder),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "EMAIL ALANI BOŞ BIRAKILAMAZ!";
                    } else if (!RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return "GEÇERLİ BİR EMAIL ADRESİ GİRİN!";
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    widget.user.email = value;
                  },
                ),
                SizedBox(
                  height: 50.0,
                ),
                TextFormField(
                  controller: passwordConroller,
                  decoration: InputDecoration(
                      labelText: "ŞİFRE",
                      labelStyle: inputText,
                      focusedBorder: inputBorder),
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "ŞİFRE ALANI BOŞ BIRAKILAMAZ!";
                    } else if (value.trim().length < 8) {
                      return "ŞİFRE 8 KARAKTERDEN AZ OLAMAZ!";
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    widget.user.password = value;
                  },
                ),
                SizedBox(
                  height: 40.0,
                ),
                TextFormField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                      labelText: "ŞİFRE ONAY",
                      labelStyle: inputText,
                      focusedBorder: inputBorder),
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "ŞİFRE ONAY ALANI BOŞ BIRAKILAMAZ!";
                    } else if (passwordConroller.text !=
                        confirmPasswordController.text) {
                      return "ŞİFRELER FARKLI OLAMAZ";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 90.0,
                ),
                Button(
                  buttonColor: primaryColor,
                  buttonFunction: () => next(),
                  buttonText: "DEVAM ET",
                ),
                SizedBox(
                  height: 50.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void next() {
    var formState = formKey.currentState;
    if (formState.validate()) {
      formState.save();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => Register2(
            user: widget.user,
          ),
        ),
      );
    }
  }
}
