import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/models/petting.dart';
import 'package:thepeti/models/user.dart';
import 'package:thepeti/widgets/button.dart';

class MyPetting extends StatefulWidget {
  final Petting petting;
  final User user;

  const MyPetting({Key key, this.petting, this.user}) : super(key: key);
  @override
  _MyPettingState createState() => _MyPettingState();
}

class _MyPettingState extends State<MyPetting> {
  DateFormat formatter = DateFormat('dd/MM/yyyy');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PETTING - " +
              formatter
                  .format((widget.petting.pettingDate).toDate())
                  .toString(),
          style: textBlackC,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(25.0, 40.0, 25.0, 40.0),
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "PETTING ÜCRETİ : " + widget.petting.price.toString(),
                    style: text30,
                  )
                ],
              ),
              SizedBox(
                height: 25.0,
              ),
              Divider(
                color: Colors.grey[500],
                thickness: 3.0,
              ),
              SizedBox(
                height: 30.0,
              ),
              InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => Register1(
                  //       user: newUser,
                  //     ),
                  //   ),
                  // );
                },
                child: Text(
                  "İLANI GÖRÜNTÜLE",
                  style: textPrimaryC,
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              Button(
                buttonColor: primaryColor,
                buttonText: "İLANI DÜZENLE",
                buttonFunction: () => null,
              ),
              SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "PETTING İSTEKLERİ",
                    style: text30,
                  )
                ],
              ),
              SizedBox(
                height: 25.0,
              ),
              Divider(
                color: Colors.grey[500],
                thickness: 3.0,
              ),
            ],
          )
        ],
      ),
    );
  }
}
