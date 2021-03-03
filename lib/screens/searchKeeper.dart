import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/screens/profile.dart';
import 'package:thepeti/services/authorizationService.dart';

class SearchKeeper extends StatefulWidget {
  @override
  _SearchKeeperState createState() => _SearchKeeperState();
}

class _SearchKeeperState extends State<SearchKeeper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BAKICI ARA",
          style: textBlackC,
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              icon: Icon(Icons.mail_outline, color: Colors.black),
              onPressed: null),
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
              })
        ],
      ),
    );
  }
}
