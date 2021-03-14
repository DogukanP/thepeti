import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/models/user.dart';
import 'package:thepeti/screens/editProfile.dart';
import 'package:thepeti/services/authorizationService.dart';
import 'package:thepeti/services/fireStoreService.dart';
import 'package:thepeti/widgets/calculateAge.dart';

class Profile extends StatefulWidget {
  final String profileOwnerId;
  const Profile({Key key, this.profileOwnerId}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User profileOwner;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PROFİL",
          style: textBlackC,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfile(
                              profile: profileOwner,
                            )));
              }),
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
            profileOwner = snapshot.data;

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
                          profileData.firstName
                              .split(" ")[0]
                              .toString()
                              .toUpperCase(),
                          style: text18,
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        (profileData.birthDate != null ||
                                // ignore: unrelated_type_equality_checks
                                profileData.birthDate == "")
                            ? Text(
                                calculateAge(profileData.birthDate.toDate())
                                        .toString() +
                                    " YAŞINDA",
                                style: text18,
                              )
                            : SizedBox(
                                height: 0,
                              ),
                        Container(
                          height: 1.3,
                          color: Colors.grey[500],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            child: (profileData.bio != "")
                ? Column(
                    children: [
                      SizedBox(
                        height: 50.0,
                      ),
                      Container(
                        height: 3.5,
                        color: Colors.grey,
                      ),
                    ],
                  )
                : SizedBox(
                    height: 0,
                  ),
          ),
          SizedBox(
            height: 35.0,
          ),
          Column(
            children: [
              Container(
                child: (profileData.bio != "")
                    ? Text(
                        profileData.bio.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: text18,
                      )
                    : SizedBox(
                        height: 5,
                      ),
              ),
              SizedBox(
                height: 35.0,
              ),
              Container(
                height: 3.5,
                color: Colors.grey,
              ),
            ],
          )
        ],
      ),
    );
  }

  logout() {
    Provider.of<AuthorizationService>(context, listen: false).logOut();
  }
}
