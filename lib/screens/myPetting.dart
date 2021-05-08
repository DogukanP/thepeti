import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/models/petting.dart';
import 'package:thepeti/models/request.dart';
import 'package:thepeti/models/user.dart';
import 'package:thepeti/screens/searchKeeper/searchDetail.dart';
import 'package:thepeti/services/fireStoreService.dart';
import 'package:thepeti/widgets/confirmReqCard.dart';
import 'package:thepeti/widgets/pettingRequestCard.dart';

class MyPetting extends StatefulWidget {
  final Petting petting;
  final User user;

  const MyPetting({Key key, this.petting, this.user}) : super(key: key);
  @override
  _MyPettingState createState() => _MyPettingState();
}

class _MyPettingState extends State<MyPetting> {
  DateFormat formatter = DateFormat('dd/MM/yyyy');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PETTING - " +
              formatter
                  .format((widget.petting.pettingDate).toDate())
                  .toString(),
          style: textBlackC,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(25.0, 40.0, 25.0, 40.0),
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "PETTING ÜCRETİ : ${widget.petting.price} TL",
                    style: text30,
                  )
                ],
              ),
              SizedBox(
                height: 25.0,
              ),
              Divider(
                color: Colors.grey[500],
                thickness: 3.0,
              ),
              SizedBox(
                height: 30.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => SearchDetail(
                        petting: widget.petting,
                        user: widget.user,
                      ),
                    ),
                  );
                },
                child: Text(
                  "İLANI GÖRÜNTÜLE",
                  style: textPrimaryC,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              getConfirmReq(widget.petting.pettingId),
              SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "PETTING İSTEKLERİ",
                    style: text30,
                  )
                ],
              ),
              SizedBox(
                height: 25.0,
              ),
              Divider(
                color: Colors.grey[500],
                thickness: 3.0,
              ),
              SizedBox(
                height: 20.0,
              ),
              getNotConfirmReq(widget.petting.pettingId),
            ],
          )
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
              return ConfirmReqCard(
                request: req,
              );
            });
      },
    );
  }

  getNotConfirmReq(pettingId) {
    return StreamBuilder<QuerySnapshot>(
      stream: FireStoreService().getNotConfirmRequest(pettingId),
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
              return PettingRequestCard(
                request: req,
              );
            });
      },
    );
  }
}
