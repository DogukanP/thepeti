import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:thepeti/constants.dart';
import 'package:thepeti/models/petting.dart';
import 'package:thepeti/models/user.dart';

class MyRequest extends StatefulWidget {
  final Petting petting;
  final User user;

  const MyRequest({Key key, this.petting, this.user}) : super(key: key);
  @override
  _MyRequestState createState() => _MyRequestState();
}

class _MyRequestState extends State<MyRequest> {
  DateFormat formatter = DateFormat('dd/MM/yyyy');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text(
        //     "PETTING - " + formatter.format((widget.petting.pettingDate).toDate()).toString(),
        //     style: textBlackC,
        //   ),
        //   centerTitle: true,
        //   backgroundColor: Colors.white,
        // ),
        );
  }
}
