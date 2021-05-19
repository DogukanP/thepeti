import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/models/petting.dart';
import 'package:thepeti/models/user.dart';
import 'package:thepeti/services/authorizationService.dart';
import 'package:thepeti/services/fireStoreService.dart';
import 'package:thepeti/widgets/button.dart';

class CreateRating extends StatefulWidget {
  final Petting petting;
  final User user;

  const CreateRating({Key key, this.petting, this.user}) : super(key: key);
  @override
  _CreateRatingState createState() => _CreateRatingState();
}

class _CreateRatingState extends State<CreateRating> {
  bool isThere = false;
  var formKey = GlobalKey<FormState>();
  double rating = 0.0;
  String comment;

  ratingControl() async {
    bool rate = await FireStoreService().ratingControl(
        widget.petting.pettingId,
        Provider.of<AuthorizationService>(context, listen: false).activeUserId,
        widget.user.userId);
    setState(() {
      isThere = rate;
    });
  }

  @override
  void initState() {
    super.initState();
    ratingControl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "DEĞERLENDİRME",
          style: textBlackC,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: ListView(
          padding: isThere == true
              ? EdgeInsets.symmetric(vertical: 80.0, horizontal: 25.0)
              : const EdgeInsets.only(
                  top: 25.0, bottom: 25.0, left: 25.0, right: 25.0),
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      radius: 70.0,
                      backgroundImage: widget.user.imageURL.isNotEmpty
                          ? NetworkImage(widget.user.imageURL)
                          : AssetImage("assets/profile_photo.png"),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.user.firstName
                          .split(" ")[0]
                          .toString()
                          .toUpperCase(),
                      style: text30,
                    ),
                  ],
                ),
                SizedBox(
                  height: 25.0,
                ),
                Divider(
                  thickness: 1.8,
                  color: Colors.grey[500],
                ),
                SizedBox(
                  height: 40.0,
                ),
                isThere == false
                    ? ratingEmployee()
                    : Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.announcement,
                                size: 100.0,
                                color: primaryColor,
                              ),
                              Expanded(
                                child: Text(
                                  "BU KULLANICI İÇİN DAHA ÖNCE DEĞERLENDİRME YAPILDI.",
                                  textAlign: TextAlign.center,
                                  style: text18,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
              ],
            ),
          ]),
    );
  }

  Widget ratingEmployee() {
    return Column(
      children: [
        SmoothStarRating(
          borderColor: primaryColor,
          color: primaryColor,
          size: 50.0,
          isReadOnly: false,
          allowHalfRating: false,
          spacing: 5,
          rating: rating,
          onRated: (value) {
            setState(() {
              rating = value;
            });
          },
        ),
        SizedBox(
          height: 35.0,
        ),
        Form(
          key: formKey,
          child: TextFormField(
            maxLength: 300,
            maxLines: 15,
            minLines: 1,
            decoration: InputDecoration(
              labelText: "PETTİNG DEĞERLENDİRMENİZ",
              labelStyle: inputText,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: primaryColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(color: primaryColor),
              ),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return "DEĞERLENDİRME ALANI BOŞ BIRAKILAMAZ!";
              } else if (value.length < 20) {
                return "DEĞERLENDİRME ALANI 20 KARAKTERDEN AZ OLAMAZ!";
              }
              return null;
            },
            onSaved: (String value) {
              comment = value;
            },
          ),
        ),
        SizedBox(
          height: 40.0,
        ),
        Button(
          buttonColor: primaryColor,
          buttonText: "DEĞERLENDİR",
          buttonFunction: () => createRating(),
        ),
      ],
    );
  }

  createRating() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      String activeUserId =
          Provider.of<AuthorizationService>(context, listen: false)
              .activeUserId;
      FireStoreService().createRating(
          comment: comment,
          pettingId: widget.petting.pettingId,
          rating: rating.toString(),
          senderId: activeUserId,
          receiverId: widget.user.userId);
      Navigator.pop(context);
      setState(() {
        isThere = true;
      });
    }
  }
}
