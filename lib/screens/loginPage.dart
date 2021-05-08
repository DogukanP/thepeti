import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/screens/forgotPassword.dart';
// import 'package:thepeti/screens/forgotPassword.dart';
import 'package:thepeti/screens/register/register1.dart';
import 'package:thepeti/services/authorizationService.dart';
import 'package:thepeti/models/user.dart';
import 'package:thepeti/services/fireStoreService.dart';
import 'package:thepeti/widgets/button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;
  String email, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [
          pageEmployee(),
          loadingAnimation(),
        ],
      ),
    );
  }

  Widget loadingAnimation() {
    if (loading) {
      return Center(
          child: CircularProgressIndicator(
        backgroundColor: primaryColor,
      ));
    } else
      return SizedBox(
        height: 0.0,
      );
  }

  Form pageEmployee() {
    final newUser = new User();
    return Form(
      key: formKey,
      child: ListView(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        children: [
          Container(
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 60.0, 0.0, 0.0),
                  child: Text(
                    "GİRİŞ",
                    style: text80,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 145.0, 0.0, 0.0),
                  child: Text(
                    "YAP",
                    style: text80,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
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
            height: 20.0,
          ),
          TextFormField(
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
            onSaved: (value) => password = value,
          ),
          SizedBox(
            height: 5.0,
          ),
          Container(
            alignment: Alignment(1.0, 0.0),
            padding: EdgeInsets.only(top: 15.0, left: 20.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForgotPassword(),
                  ),
                );
              },
              child: Text(
                "ŞİFREMİ UNUTTUM",
                style: textPrimaryC,
              ),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Button(
            buttonColor: primaryColor,
            buttonFunction: () => login(),
            buttonText: "GİRİŞ YAP",
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            height: 60.0,
            width: 400.0,
            child: GestureDetector(
              onTap: () => signInWithGoogle(),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: primaryColor,
                    style: BorderStyle.solid,
                    width: 1.8,
                  ),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Image(
                        image: AssetImage("assets/google.png"),
                        height: 35.0,
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Center(
                      child: Text(
                        "GOOGLE İLE GİRİŞ YAP",
                        style: textPrimaryC,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "BİR HESABIN YOK MU ?",
                style: textBlackC18,
              ),
              SizedBox(
                width: 5.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Register1(
                        user: newUser,
                      ),
                    ),
                  );
                },
                child: Text(
                  "KAYDOL",
                  style: textPrimaryC,
                ),
              )
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }

  void login() async {
    final authorizationService =
        Provider.of<AuthorizationService>(context, listen: false);
    var formState = formKey.currentState;
    if (formState.validate()) {
      formState.save();
      setState(() {
        loading = true;
      });

      try {
        await authorizationService.loginByMail(email, password);
      } catch (e) {
        setState(() {
          loading = false;
          showError(errorCode: e.code);
        });
      }
    }
  }

  void signInWithGoogle() async {
    var authanticationService =
        Provider.of<AuthorizationService>(context, listen: false);
    setState(() {
      loading = true;
    });
    try {
      User user = await authanticationService.signInWithGoogle();
      if (user != null) {
        User fireStoreUser = await FireStoreService().getUser(user.userId);
        if (fireStoreUser == null) {
          FireStoreService().createUser(
            userId: user.userId,
            email: user.email,
            firstName: user.firstName,
            imageURL: user.imageURL,
          );
        }
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      showError(errorCode: e.code);
    }
  }

  showError({errorCode}) {
    String errorMessage;
    if (errorCode == "ERROR_INVALID_EMAIL") {
      errorMessage = "Girdiğiniz mail adresi geçersizdir";
    } else if (errorCode == "ERROR_USER_NOT_FOUND") {
      errorMessage = "Girdiğiniz kullanıcı bulunmuyor";
    } else if (errorCode == "ERROR_WRONG_PASSWORD") {
      errorMessage = "Girdiğiniz şifre hatalı";
    } else if (errorCode == "ERROR_USER_DISABLED") {
      errorMessage = "Kullanıcı engellenmiş";
    } else {
      errorMessage = "Tanımlanamayan bir hata oluştu $errorCode";
    }

    var snackBar = SnackBar(
      backgroundColor: primaryColor,
      content: Text(errorMessage),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
