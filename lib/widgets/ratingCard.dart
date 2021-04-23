import 'package:flutter/material.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/models/petting.dart';
import 'package:thepeti/models/request.dart';
import 'package:thepeti/models/user.dart';
import 'package:thepeti/screens/rating/createRating.dart';
import 'package:thepeti/services/fireStoreService.dart';

class RatingCard extends StatefulWidget {
  final Request request;
  final Petting petting;
  const RatingCard({Key key, this.request, this.petting}) : super(key: key);
  @override
  _RatingCardState createState() => _RatingCardState();
}

class _RatingCardState extends State<RatingCard> {
  @override
  Widget build(BuildContext context) => FutureBuilder<User>(
        future: FireStoreService().getUser(widget.request.ownerId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
              height: 0.0,
            );
          }
          User user = snapshot.data;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => CreateRating(
                          user: user,
                          petting: widget.petting,
                        )),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                    height: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40.0,
                          backgroundColor: Colors.grey,
                          backgroundImage: user.imageURL.isNotEmpty
                              ? NetworkImage(user.imageURL)
                              : AssetImage("assets/profile_photo.png"),
                        ),
                        SizedBox(
                          width: 25.0,
                        ),
                        Text(user.firstName, style: text23),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
}
