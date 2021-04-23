import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/models/petting.dart';
import 'package:thepeti/models/user.dart';
import 'package:thepeti/screens/rating/createRating.dart';
import 'package:thepeti/screens/rating/createRatingMyP.dart';
import 'package:thepeti/services/authorizationService.dart';

class PastPettingCard extends StatefulWidget {
  final Petting petting;
  final User user;

  const PastPettingCard({Key key, this.petting, this.user}) : super(key: key);
  @override
  _PastPettingCardState createState() => _PastPettingCardState();
}

class _PastPettingCardState extends State<PastPettingCard> {
  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('dd/MM/yyyy');

    String activeUserId =
        Provider.of<AuthorizationService>(context, listen: false).activeUserId;
    return GestureDetector(
      onTap: () {
        if (activeUserId == widget.petting.userId) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => CreateRatingMyP(
                petting: widget.petting,
                user: widget.user,
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => CreateRating(
                petting: widget.petting,
                user: widget.user,
              ),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              height: 180.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            formatter
                                .format(widget.petting.pettingDate.toDate())
                                .toString(),
                            style: text30,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey,
                                backgroundImage: widget.user.imageURL.isNotEmpty
                                    ? NetworkImage(widget.user.imageURL)
                                    : AssetImage("assets/profile_photo.png"),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.user.firstName
                                    .split(" ")[0]
                                    .toString()
                                    .toUpperCase(),
                                style: text18,
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        width: 55,
                      ),
                      Column(
                        children: [
                          Text(
                            "${widget.petting.price}",
                            style: text50,
                          ),
                          Text(
                            "TL",
                            style: text50,
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
