import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/models/peti.dart';
import 'package:thepeti/models/user.dart';
import 'package:thepeti/screens/chat/chatPage.dart';
import 'package:thepeti/screens/profile/editProfile.dart';
import 'package:thepeti/screens/rating/ratingScreen.dart';
import 'package:thepeti/services/authorizationService.dart';
import 'package:thepeti/services/fireStoreService.dart';
import 'package:thepeti/widgets/button.dart';
import 'package:thepeti/widgets/calculateAge.dart';
import 'package:thepeti/widgets/petiCardProfile.dart';

class Profile extends StatefulWidget {
  final String profileOwnerId;
  const Profile({Key key, this.profileOwnerId}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  GlobalKey<FormState> formkey = GlobalKey();
  bool active;
  User profileOwner;
  @override
  Widget build(BuildContext context) {
    String activeUserId =
        Provider.of<AuthorizationService>(context, listen: false).activeUserId;
    activeUserId == widget.profileOwnerId ? active = true : active = false;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PROFİL",
          style: textBlackC,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: [
          Center(
            child: active == true
                ? IconButton(
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
                          ),
                        ),
                      );
                    },
                  )
                : SizedBox(
                    height: 0.0,
                  ),
          ),
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
                peti(),
                Center(
                  child: active == true
                      ? Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 50.0, bottom: 50.0),
                          child: Button(
                            buttonColor: Colors.red,
                            buttonFunction: () => logout(),
                            buttonText: "ÇIKIŞ YAP",
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 50.0, bottom: 50.0),
                          child: Button(
                            buttonColor: Colors.red,
                            buttonFunction: () => complaint(
                                activeUserId, widget.profileOwnerId), //complain
                            buttonText: "ŞİKAYET ET",
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
                    ? NetworkImage(profileData?.imageURL)
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
          Center(
            child: active == true
                ? SizedBox(
                    height: 30.0,
                  )
                : Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: Column(
                      children: [
                        Divider(
                          thickness: 3.0,
                          color: Colors.grey[500],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatPage(
                                  chattedUser: profileOwner,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "MESAJ GÖNDER",
                            style: textPrimaryC,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          Container(
            child: (profileData.bio != "")
                ? Column(
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      Divider(
                        thickness: 3.0,
                        color: Colors.grey[500],
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
              Divider(
                thickness: 3.0,
                color: Colors.grey[500],
              ),
              SizedBox(
                height: 30.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RatingScreen(
                              user: profileOwner,
                            )),
                  );
                },
                child: Text(
                  "DEĞERLENDİRMELER ",
                  style: textPrimaryC,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Divider(
                color: Colors.grey[500],
                thickness: 3,
              )
            ],
          )
        ],
      ),
    );
  }

  peti() {
    return StreamBuilder<QuerySnapshot>(
      stream: FireStoreService().getPetisLive(widget.profileOwnerId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SizedBox(
            height: 0.0,
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index) {
            Peti peti = Peti.createFromDocument(snapshot.data.documents[index]);
            return PetiCardProfile(
              peti: peti,
            );
          },
        );
      },
    );
  }

  Future<void> complaint(activeUserId, profileOwnerId) async {
    String note;
    TextEditingController controller = TextEditingController();
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Form(
            key: formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  maxLength: 300,
                  controller: controller,
                  validator: (value) {
                    return value.isNotEmpty
                        ? null
                        : "LÜTFEN ŞİKAYET NOTUNUZU YAZIN";
                  },
                  onSaved: (String value) {
                    note = value;
                  },
                  decoration: InputDecoration(hintText: "ŞİKAYET NOTU GİRİNİZ"),
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text("ŞİKAYET ET"),
              onPressed: () async {
                if (formkey.currentState.validate()) {
                  formkey.currentState.save();
                  await FireStoreService().createComplaint(
                      note: note,
                      receiverId: profileOwnerId,
                      senderId: activeUserId);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  logout() {
    Provider.of<AuthorizationService>(context, listen: false).logOut();
    Navigator.pop(context);
  }
}
