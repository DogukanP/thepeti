import 'package:flutter/material.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/models/peti.dart';
import 'package:thepeti/models/petting.dart';
import 'package:thepeti/models/user.dart';
import 'package:thepeti/screens/searchKeeper/searchDetail.dart';

class SearchCard extends StatefulWidget {
  final Petting petting;
  final User user;
  final Peti peti;

  const SearchCard({Key key, this.petting, this.user, this.peti})
      : super(key: key);
  @override
  _SearchCardState createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchDetail(
                user: widget.user, petting: widget.petting, peti: widget.peti),
          ),
        );
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
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.grey,
                                backgroundImage: widget.user.imageURL.isNotEmpty
                                    ? NetworkImage(widget.user.imageURL)
                                    // : AssetImage("assets/profile_photo.png"),
                                    : null,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.user.firstName
                                    .split(" ")[0]
                                    .toString()
                                    .toUpperCase(),
                                style: text23,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              widget.petting.district,
                              style: text23,
                            ),
                          ),
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
