import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/models/peti.dart';
import 'package:thepeti/models/petting.dart';
import 'package:thepeti/models/request.dart';
import 'package:thepeti/models/user.dart';
import 'package:thepeti/screens/homeScreens/homeScreen.dart';
import 'package:thepeti/screens/profile/profile.dart';
import 'package:thepeti/services/authorizationService.dart';
import 'package:thepeti/services/fireStoreService.dart';
import 'package:thepeti/widgets/button.dart';

class SearchDetail extends StatefulWidget {
  final Petting petting;
  final User user;
  final Peti peti;
  final bool confirm;

  const SearchDetail(
      {Key key, this.petting, this.user, this.peti, this.confirm})
      : super(key: key);

  @override
  _SearchDetailState createState() => _SearchDetailState();
}

class _SearchDetailState extends State<SearchDetail> {
  bool loading = false;
  bool active;
  bool isThere = false;
  bool status;
  DateFormat formatter = DateFormat('dd/MM/yyyy');

  reqControl() async {
    String activeUserId =
        Provider.of<AuthorizationService>(context, listen: false).activeUserId;
    bool isThereReq = await FireStoreService()
        .reqControl(widget.petting.pettingId, activeUserId);
    setState(() {
      isThere = isThereReq;
    });
  }

  req() async {
    String activeUserId =
        Provider.of<AuthorizationService>(context, listen: false).activeUserId;
    Request req = await FireStoreService()
        .getRequest(widget.petting.pettingId, activeUserId);
    setState(() {
      status = req.confirm;
    });
  }

  @override
  void initState() {
    super.initState();
    reqControl();
    req();
  }

  @override
  Widget build(BuildContext context) {
    String activeUserId =
        Provider.of<AuthorizationService>(context, listen: false).activeUserId;
    activeUserId == widget.user.userId ? active = true : active = false;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PETTING  -  " +
              formatter.format(widget.petting.pettingDate.toDate()).toString(),
          style: textBlackC,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 50.0),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 45.0,
                backgroundImage: widget.user.imageURL.isNotEmpty
                    ? NetworkImage(widget.user.imageURL)
                    : AssetImage("assets/profile_photo.png"),
              ),
              SizedBox(
                width: 10.0,
              ),
              Column(
                children: [
                  Text(
                    widget.user.firstName.split(" ")[0],
                    style: text18,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    widget.petting.district,
                    style: text18,
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 40.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profile(
                        profileOwnerId: widget.petting.userId,
                      ),
                    ),
                  );
                },
                child: Text(
                  "PROFİLİ GÖR",
                  style: textPrimaryC,
                ),
              ),
            ],
          ),
          widget.confirm == false
              ? SizedBox(
                  height: 0.0,
                )
              : active == false
                  ? Center(
                      child: status == true
                          ? SizedBox(
                              height: 0.0,
                            )
                          : Column(
                              children: [
                                Divider(
                                  color: Colors.grey[500],
                                  thickness: 3.0,
                                  height: 100.0,
                                ),
                                Text(
                                  "BAKICI ONAYI BEKLENİYOR",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Montserrat"),
                                ),
                              ],
                            ),
                    )
                  : SizedBox(
                      height: 0.0,
                    ),
          Divider(
            color: Colors.grey[500],
            thickness: 3.0,
            height: 100.0,
          ),
          Text(widget.petting.note, textAlign: TextAlign.center, style: text18),
          Divider(
            color: Colors.grey[500],
            thickness: 3.0,
            height: 100.0,
          ),
          Text(
            "1 PETİ İÇİN BAKIM ÜCRETİ",
            style: text23,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            "${widget.petting.price} TL",
            style: text30,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 50.0,
          ),
          active == false
              ? Center(
                  child: isThere == false
                      ? Button(
                          buttonColor: primaryColor,
                          buttonFunction: () => createRequest(),
                          buttonText: "İSTEK GÖNDER",
                        )
                      : Button(
                          buttonColor: Colors.red,
                          buttonFunction: () =>
                              deleteReq(widget.petting.pettingId, activeUserId),
                          buttonText: "İPTAL ET",
                        ),
                )
              : Button(
                  buttonColor: Colors.red,
                  buttonFunction: () => cancel(widget.petting.pettingId),
                  buttonText: "İPTAL ET",
                ),
          SizedBox(
            height: 10.0,
          ),
          loading
              ? LinearProgressIndicator(
                  backgroundColor: primaryColor,
                )
              : SizedBox(
                  height: 0.0,
                ),
        ],
      ),
    );
  }

  createRequest() async {
    if (!loading) {
      setState(() {
        loading = true;
      });
      String activeUserId =
          Provider.of<AuthorizationService>(context, listen: false)
              .activeUserId;
      await FireStoreService().createRequest(
          petiId: widget.peti.petiId,
          pettingId: widget.petting.pettingId,
          userId: activeUserId);

      setState(() {
        loading = false;
        setState(() {
          isThere = true;
        });
      });

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
          (Route<dynamic> route) => route is HomeScreen);
    }
  }

  cancel(String pettingId) {
    FireStoreService().deletePetting(pettingId);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
        (Route<dynamic> route) => route is HomeScreen);
  }

  deleteReq(pettingId, ownerId) {
    FireStoreService().deleteRequestNoReqId(pettingId, ownerId);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
        (Route<dynamic> route) => route is HomeScreen);

    setState(() {
      isThere = true;
    });
  }
}
