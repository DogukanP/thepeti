import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/models/petting.dart';
import 'package:thepeti/models/request.dart';
import 'package:thepeti/models/user.dart';
import 'package:thepeti/services/fireStoreService.dart';
import 'package:thepeti/widgets/ratingCard.dart';

class CreateRatingMyP extends StatefulWidget {
  final Petting petting;
  final User user;

  const CreateRatingMyP({Key key, this.petting, this.user}) : super(key: key);
  @override
  _CreateRatingMyPState createState() => _CreateRatingMyPState();
}

class _CreateRatingMyPState extends State<CreateRatingMyP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "DEĞERLENDİRME",
          style: textBlackC,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(25.0, 40.0, 25.0, 40.0),
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 100.0,
                color: primaryColor,
              ),
              Expanded(
                child: Text(
                  "DEĞERLENDİRMEK İSTEDİĞİNİZ KİŞİYE TIKLAYARAK DEĞERLENDİRME YAPABİLİRSİNİZ",
                  textAlign: TextAlign.center,
                  style: text18,
                ),
              ),
            ],
          ),
          Divider(
            height: 40.0,
            thickness: 1.3,
            color: primaryColor,
          ),
          // SizedBox(
          //   height: 20.0,
          // ),
          getConfirmReq(widget.petting.pettingId)
        ],
      ),
    );
  }

  getConfirmReq(pettingId) {
    return StreamBuilder<QuerySnapshot>(
      stream: FireStoreService().getConfirmRequest(pettingId),
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
              Request req =
                  Request.createFromDocument(snapshot.data.documents[index]);
              return RatingCard(
                request: req,
                petting: widget.petting,
              );
            });
      },
    );
  }
}
