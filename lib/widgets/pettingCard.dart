import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/models/petting.dart';
import 'package:thepeti/models/request.dart';
import 'package:thepeti/models/user.dart';
import 'package:thepeti/screens/myPetting.dart';
import 'package:thepeti/screens/searchKeeper/searchDetail.dart';
import 'package:thepeti/services/authorizationService.dart';
import 'package:thepeti/services/fireStoreService.dart';

class PettingCard extends StatefulWidget {
  final Petting petting;
  final User user;

  const PettingCard({Key key, this.petting, this.user}) : super(key: key);
  @override
  _PettingCardState createState() => _PettingCardState();
}

class _PettingCardState extends State<PettingCard> {
  DateFormat formatter = DateFormat('dd/MM/yyyy');
  bool isThereReq;
  isThereRequest() async {
    List<Request> reqs = await FireStoreService()
        .getRequestsForControl(widget.petting.pettingId);
    bool req;
    if (reqs.length == 0) {
      req = false;
    } else
      req = true;
    setState(() {
      isThereReq = req;
    });
  }

  //üstteki satırları pettingScreen kısmında yaparsan yenilediğinde dinamik olarak gözükür

  @override
  void initState() {
    super.initState();
    isThereRequest();
  }

  @override
  Widget build(BuildContext context) {
    String activeUserId =
        Provider.of<AuthorizationService>(context, listen: false).activeUserId;
    return GestureDetector(
      onTap: () {
        if (activeUserId == widget.petting.userId) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => MyPetting(
                petting: widget.petting,
                user: widget.user,
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => SearchDetail(
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
                children: [
                  activeUserId == widget.petting.userId
                      ? Center(
                          child: isThereReq == true
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "BAKIM İSTEĞİ VAR",
                                      style: textPrimaryC,
                                    ),
                                  ],
                                )
                              : SizedBox(
                                  height: 20.0,
                                ),
                        )
                      : Center(
                          child: isThereReq == true
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "BAKICI ONAYI BEKLENİYOR",
                                      style: textPrimaryC,
                                    ),
                                  ],
                                )
                              : SizedBox(
                                  height: 20.0,
                                ),
                        ),
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
