import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/models/petting.dart';
import 'package:thepeti/models/request.dart';
import 'package:thepeti/models/user.dart';
import 'package:thepeti/services/authorizationService.dart';
import 'package:thepeti/services/fireStoreService.dart';
import 'package:thepeti/widgets/pastPettingCard.dart';

class PastPettings extends StatefulWidget {
  @override
  _PastPettingsState createState() => _PastPettingsState();
}

class _PastPettingsState extends State<PastPettings> {
  List<Petting> pettingList = [];

  Future<void> getPettings() async {
    String activeUserId =
        Provider.of<AuthorizationService>(context, listen: false).activeUserId;
    List<Petting> pettings =
        await FireStoreService().getPettingsArchive(activeUserId);
    List<Request> requests = await FireStoreService().getRequests(activeUserId);
    requests.forEach((element) async {
      Petting petting = await FireStoreService().getPetting(element.pettingId);
      setState(() {
        if (petting.pettingDate.seconds <
            Timestamp.fromDate(DateTime.now().subtract(new Duration(days: 1)))
                .seconds) {
          pettings.add(petting);
        }
      });
    });
    setState(() {
      pettingList = pettings;
    });
  }

  @override
  void initState() {
    super.initState();
    getPettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "GEÇMİŞ  PETTINGLER",
          style: textBlackC,
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: pettingList.length,
        itemBuilder: (context, index) {
          Petting petting = pettingList[index];
          return FutureBuilder(
            future: FireStoreService().getUser(petting.userId),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  color: Colors.white,
                  height: 500,
                );
              }
              User user = snapshot.data;

              return PastPettingCard(
                petting: petting,
                user: user,
              );
            },
          );
        },
      ),
    );
  }
}
