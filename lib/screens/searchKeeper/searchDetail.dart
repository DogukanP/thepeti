import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/models/peti.dart';
import 'package:thepeti/models/petting.dart';
import 'package:thepeti/models/user.dart';
import 'package:thepeti/screens/homeScreens/homeScreen.dart';
import 'package:thepeti/screens/profile/profile.dart';
import 'package:thepeti/services/authorizationService.dart';
import 'package:thepeti/services/fireStoreService.dart';
import 'package:thepeti/widgets/button.dart';

class SearchDetail extends StatefulWidget {
  final Petting petting;
  final User user;
  final Peti peti;

  const SearchDetail({Key key, this.petting, this.user, this.peti})
      : super(key: key);

  @override
  _SearchDetailState createState() => _SearchDetailState();
}

class _SearchDetailState extends State<SearchDetail> {
  bool loading = false;
  DateFormat formatter = DateFormat('dd/MM/yyyy');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PETTING  -  " +
              formatter.format(widget.petting.pettingDate.toDate()).toString(),
          style: textBlackC,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 50.0),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 45.0,
                backgroundImage: widget.user.imageURL.isNotEmpty
                    ? NetworkImage(widget.user.imageURL)
                    : AssetImage("assets/profile_photo.png"),
              ),
              SizedBox(
                width: 10.0,
              ),
              Column(
                children: [
                  Text(
                    widget.user.firstName.split(" ")[0],
                    style: text18,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Text("PUAN", style: text18),
                      SizedBox(
                        width: 5.0,
                      ),
                      Icon(Icons.star),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: 30.0,
              ),
              Text(
                widget.petting.district,
                style: text18,
              ),
            ],
          ),
          SizedBox(
            height: 40.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profile(
                        profileOwnerId: widget.petting.userId,
                      ),
                    ),
                  );
                },
                child: Text(
                  "PROFİLİ GÖR",
                  style: textPrimaryC,
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.grey[500],
            thickness: 3.0,
            height: 100.0,
          ),
          Text(widget.petting.note, textAlign: TextAlign.center, style: text18),
          Divider(
            color: Colors.grey[500],
            thickness: 3.0,
            height: 100.0,
          ),
          Text(
            "1 PETİ İÇİN BAKIM ÜCRETİ",
            style: text23,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            "${widget.petting.price} TL",
            style: text30,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 50.0,
          ),
          Button(
            buttonColor: primaryColor,
            buttonFunction: () => createRequest(),
            buttonText: "İSTEK GÖNDER",
          ),
          SizedBox(
            height: 10.0,
          ),
          loading
              ? LinearProgressIndicator(
                  backgroundColor: primaryColor,
                )
              : SizedBox(
                  height: 0.0,
                ),
        ],
      ),
    );
  }

  createRequest() async {
    if (!loading) {
      setState(() {
        loading = true;
      });
      String activeUserId =
          Provider.of<AuthorizationService>(context, listen: false)
              .activeUserId;
      await FireStoreService().createRequest(
          petiId: widget.peti.petiId,
          pettingId: widget.petting.pettingId,
          userId: activeUserId);

      setState(() {
        loading = false;
      });

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
          (Route<dynamic> route) => route is HomeScreen);
    }
  }
}
