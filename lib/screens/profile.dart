import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/models/user.dart';
import 'package:thepeti/services/authorizationService.dart';
import 'package:thepeti/services/fireStoreService.dart';

class Profile extends StatefulWidget {
  final String profileOwnerId;
  const Profile({Key key, this.profileOwnerId}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PROFİL",
          style: textBlackC,
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onPressed: null)
        ],
      ),
      body: FutureBuilder<Object>(
          future: FireStoreService().getUser(widget.profileOwnerId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: <Widget>[
                detailProfile(snapshot.data),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  height: 60,
                  width: 400,
                  child: ElevatedButton(
                    child: Text("ÇIKIŞ YAP"),
                    onPressed: () => logout(),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget detailProfile(User profileData) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                radius: 50.0,
                backgroundImage: profileData.imageURL.isNotEmpty
                    ? NetworkImage(profileData.imageURL)
                    : AssetImage("assets/profile_photo.png"),
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        profileData.firstName,
                        style: text18,
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      // Text(
                      //   profileData.birthDate,
                      //   style: text18,
                      // ),
                      Container(
                        height: 1.8,
                        color: Colors.grey[600],
                      )
                    ],
                  ),
                ],
              ))
            ],
          ),
        ],
      ),
    );
  }

  logout() {
    Provider.of<AuthorizationService>(context, listen: false).logOut();
  }
}
