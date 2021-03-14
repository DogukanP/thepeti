import 'package:flutter/material.dart';

const primaryColor = Color(0xFF01bc4e);
const shadowColor = Colors.greenAccent;
const text80 = TextStyle(
    fontSize: 80.0, fontWeight: FontWeight.bold, fontFamily: "Montserrat");
const text70 = TextStyle(
    fontSize: 70.0, fontWeight: FontWeight.bold, fontFamily: "Montserrat");
const text60 = TextStyle(
    fontSize: 60.0, fontWeight: FontWeight.bold, fontFamily: "Montserrat");
const text50 = TextStyle(
    fontSize: 50.0, fontWeight: FontWeight.bold, fontFamily: "Montserrat");
const text30 = TextStyle(
    fontSize: 30.0, fontWeight: FontWeight.bold, fontFamily: "Montserrat");
const text18 = TextStyle(
    fontSize: 18.0, fontWeight: FontWeight.bold, fontFamily: "Montserrat");
const inputText = TextStyle(
    fontFamily: "Montserrat", fontWeight: FontWeight.bold, color: Colors.grey);
const inputBorder =
    UnderlineInputBorder(borderSide: BorderSide(color: primaryColor));
const buttonText = TextStyle(
    color: Colors.white, fontWeight: FontWeight.bold, fontFamily: "Montserrat");
const textPrimaryC = TextStyle(
  color: primaryColor,
  fontWeight: FontWeight.bold,
  fontFamily: "Montserrat",
);
const textBlackC = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontFamily: "Montserrat",
);

// String activeUserId =
//         Provider.of<AuthorizationService>(context, listen: false).activeUserId;
// const textGreyC = TextStyle(
//   color: Colors.grey,
//   fontWeight: FontWeight.bold,
//   fontFamily: "Montserrat",
// );

// Container(
//             height: 60,
//             width: 400,
//             child: ElevatedButton(
//               child: Text("GİRİŞ YAP"),
//               onPressed: () => Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => LoginPage())),
//               style: ElevatedButton.styleFrom(
//                 primary: primaryColor,
//                 onPrimary: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30.0),
//                 ),
//               ),
//             ),
//           ),

// ---------------------------- user oluşturma -----------------------------------------------------
// void next() async {
//     final authorizationService =
//         Provider.of<AuthorizationService>(context, listen: false);
//     var formState = formKey.currentState;
//     if (formState.validate()) {
//       formState.save();
//       setState(() {
//         loading = true;
//       });
//       try {
//         // await authorizationService.registerByMail(email, password);
//         Navigator.push(context,
//             MaterialPageRoute(builder: (BuildContext context) => Register2()));
//       } catch (e) {
//         setState(() {
//           loading = false;
//           showError(errorCode: e.code);
//         });
//       }
//     }
//   }
