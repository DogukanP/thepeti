import 'package:flutter/material.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/models/rating.dart';
import 'package:thepeti/models/user.dart';

class RatingCardProfile extends StatefulWidget {
  final User user;
  final Rating rating;

  const RatingCardProfile({Key key, this.user, this.rating}) : super(key: key);
  @override
  _RatingCardProfileState createState() => _RatingCardProfileState();
}

class _RatingCardProfileState extends State<RatingCardProfile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Container(
        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.grey,
                  backgroundImage: widget.user.imageURL.isNotEmpty
                      ? NetworkImage(widget.user.imageURL)
                      : AssetImage("assets/profile_photo.png"),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  widget.user.firstName.split(" ")[0].toString().toUpperCase(),
                  style: text18,
                ),
                SizedBox(
                  width: 40.0,
                ),
                Text(
                  widget.rating.rating,
                  style: text18,
                ),
                Icon(Icons.star),
              ],
            ),
            SizedBox(
              height: 25.0,
            ),
            Text(
              widget.rating.comment,
              style: text18,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
