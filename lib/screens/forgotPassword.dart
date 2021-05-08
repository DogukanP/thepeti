import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/services/authorizationService.dart';
import 'package:thepeti/widgets/button.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool loading = false;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "ŞİFREMİ UNUTTUM",
                          style: text70,
                        ),
                      ),
                      SizedBox(
                        height: 80.0,
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
                          } else if (!value.contains("@")) {
                            return "GEÇERLİ BİR EMAIL ADRESİ GİRİN!";
                          }
                          return null;
                        },
                        onSaved: (value) => email = value,
                      ),
                      SizedBox(
                        height: 130.0,
                      ),
                      Button(
                        buttonColor: primaryColor,
                        buttonText: "ŞİFREMİ SIFIRLA",
                        buttonFunction: () => resetPassword(),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      loading
                          ? LinearProgressIndicator()
                          : SizedBox(
                              height: 0.0,
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void resetPassword() async {
    final authorization =
        Provider.of<AuthorizationService>(context, listen: false);

    var formState = formKey.currentState;

    if (formState.validate()) {
      formState.save();
      setState(() {
        loading = true;
      });

      try {
        await authorization.resetPassword(email);
        Navigator.pop(context);
      } catch (hata) {
        setState(() {
          loading = false;
        });
        showError(e: hata.code);
      }
    }
  }

  showError({e}) {
    String errorMessage;

    if (e == "ERROR_INVALID_EMAIL") {
      errorMessage = "Girdiğiniz mail adresi geçersizdir";
    } else if (e == "ERROR_USER_NOT_FOUND") {
      errorMessage = "Bu mailde bir kullanıcı bulunmuyor";
    }

    var snackBar = SnackBar(
      content: Text(errorMessage),
      backgroundColor: primaryColor,
    );
    scaffoldKey.currentState.showSnackBar(
      snackBar,
    );
  }
}
