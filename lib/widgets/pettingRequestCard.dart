import 'package:flutter/material.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/models/request.dart';
import 'package:thepeti/models/user.dart';
import 'package:thepeti/screens/searchKeeper/pettingReq.dart';
import 'package:thepeti/services/fireStoreService.dart';

class PettingRequestCard extends StatefulWidget {
  final Request request;

  const PettingRequestCard({Key key, this.request}) : super(key: key);
  @override
  _PettingRequestCardState createState() => _PettingRequestCardState();
}

class _PettingRequestCardState extends State<PettingRequestCard> {
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
                  builder: (BuildContext context) => PettingReq(
                    user: snapshot.data,
                    req: widget.request,
                  ),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                    height: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(-3, 1),
                        )
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 25.0,
                          backgroundColor: Colors.grey,
                          backgroundImage: user.imageURL.isNotEmpty
                              ? NetworkImage(user.imageURL)
                              : AssetImage("assets/profile_photo.png"),
                        ),
                        SizedBox(
                          width: 25.0,
                        ),
                        Text(user.firstName, style: text18),
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
