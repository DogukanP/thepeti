// import 'package:flutter/material.dart';
// import 'package:thepeti/constants.dart';
// import 'package:thepeti/models/user.dart';
// import 'package:thepeti/screens/register1.dart';

// class ForgotPassword extends StatefulWidget {
//   @override
//   _ForgotPasswordState createState() => _ForgotPasswordState();
// }

// class _ForgotPasswordState extends State<ForgotPassword> {
//   @override
//   Widget build(BuildContext context) {
//     final newUser = new User();
//     return Scaffold(
//       resizeToAvoidBottomPadding: false,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             child: Stack(
//               children: [
//                 Container(
//                   padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
//                   child: Text(
//                     "ŞİFREMİ",
//                     style: text60,
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(15.0, 175.0, 0.0, 0.0),
//                   child: Text(
//                     "UNUTTUM",
//                     style: text60,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.only(top: 70.0, left: 20.0, right: 20.0),
//             child: Column(
//               children: [
//                 TextFormField(
//                   decoration: InputDecoration(
//                       labelText: "EMAIL",
//                       labelStyle: inputText,
//                       focusedBorder: inputBorder),
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return "EMAIL ALANI BOŞ BIRAKILAMAZ!";
//                     } else if (!value.contains("@")) {
//                       return "GEÇERLİ BİR EMAIL ADRESİ GİRİN!";
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(
//                   height: 50.0,
//                 ),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
//                   height: 60,
//                   width: 400,
//                   child: ElevatedButton(
//                     child: Text("YENİ ŞİFRE GÖNDER"),
//                     style: ElevatedButton.styleFrom(
//                       primary: primaryColor,
//                       onPrimary: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30.0),
//                       ),
//                     ),
//                     onPressed: () {},
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 50.0,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "BİR HESABIN YOK MU ?",
//                 style: textBlackC,
//               ),
//               SizedBox(
//                 width: 5.0,
//               ),
//               InkWell(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => Register1(
//                                 user: newUser,
//                               )));
//                 },
//                 child: Text(
//                   "KAYDOL",
//                   style: textPrimaryC,
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
