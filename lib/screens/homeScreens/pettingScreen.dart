import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/models/petting.dart';
import 'package:thepeti/models/request.dart';
import 'package:thepeti/models/user.dart';
import 'package:thepeti/screens/profile/profile.dart';
import 'package:thepeti/services/authorizationService.dart';
import 'package:thepeti/services/fireStoreService.dart';
import 'package:thepeti/widgets/pettingCard.dart';

class PettingScreen extends StatefulWidget {
  @override
  _PettingScreenState createState() => _PettingScreenState();
}

class _PettingScreenState extends State<PettingScreen> {
  List<Petting> pettingList = [];

  Future<void> getPettings() async {
    String activeUserId =
        Provider.of<AuthorizationService>(context, listen: false).activeUserId;
    List<Petting> pettings = await FireStoreService().getPettings(activeUserId);
    List<Request> requests = await FireStoreService().getRequest(activeUserId);
    requests.forEach((element) async {
      Petting petting = await FireStoreService().getPetting(element.pettingId);
      setState(() {
        pettings.add(petting);
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
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          "PETTING",
          style: textBlackC,
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              icon: Icon(Icons.mail_outline, color: Colors.black),
              onPressed: () {}),
          SizedBox(
            width: 5.0,
          ),
          IconButton(
              icon: Icon(
                Icons.account_circle,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Profile(
                            profileOwnerId: Provider.of<AuthorizationService>(
                                    context,
                                    listen: false)
                                .activeUserId,
                          )),
                );
              }),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: getPettings,
        child: ListView.builder(
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
                return PettingCard(
                  petting: petting,
                  user: user,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
