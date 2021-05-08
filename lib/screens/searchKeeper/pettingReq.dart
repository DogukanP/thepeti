import 'package:flutter/material.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/models/peti.dart';
import 'package:thepeti/models/request.dart';
import 'package:thepeti/models/user.dart';
import 'package:thepeti/screens/profile/profile.dart';
import 'package:thepeti/services/fireStoreService.dart';
import 'package:thepeti/widgets/button.dart';
import 'package:thepeti/widgets/calculateAge.dart';

class PettingReq extends StatefulWidget {
  final User user;
  final Request req;

  const PettingReq({Key key, this.user, this.req}) : super(key: key);
  @override
  _PettingReqState createState() => _PettingReqState();
}

class _PettingReqState extends State<PettingReq> {
  Peti peti;
  getPeti() async {
    Peti _peti = await FireStoreService().getPeti(widget.req.petiId);
    setState(() {
      peti = _peti;
    });
  }

  @override
  void initState() {
    super.initState();
    getPeti();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PETTING İSTEK",
          style: textBlackC,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(25.0, 40.0, 25.0, 40.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Colors.grey,
                  backgroundImage: widget.user.imageURL.isNotEmpty
                      ? NetworkImage(widget.user.imageURL)
                      : AssetImage("assets/profile_photo.png"),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              widget.user.firstName.split(" ")[0].toString().toUpperCase(),
              style: text18,
            ),
            SizedBox(
              height: 8.0,
            ),
            (widget.user.birthDate != null ||
                    // ignore: unrelated_type_equality_checks
                    widget.user.birthDate == "")
                ? Text(
                    calculateAge(widget.user.birthDate.toDate()).toString() +
                        " YAŞINDA",
                    style: text18,
                  )
                : SizedBox(
                    height: 0,
                  ),
            SizedBox(
              height: 25.0,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profile(
                      profileOwnerId: widget.user.userId,
                    ),
                  ),
                );
              },
              child: Text(
                "PROFİLİ GÖR",
                style: textPrimaryC,
              ),
            ),
            Divider(
              thickness: 3,
              color: Colors.grey[500],
              height: 50.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40.0,
                  backgroundColor: Colors.grey,
                  backgroundImage: peti.imageURL.isNotEmpty
                      ? NetworkImage(peti.imageURL)
                      : AssetImage("assets/profile_photo.png"),
                ),
                SizedBox(
                  width: 25.0,
                ),
                Column(
                  children: [
                    Text(
                      peti.name,
                      style: text18,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(peti.genus, style: text18),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 40.0,
            ),
            Button(
              buttonColor: primaryColor,
              buttonText: "KABUL ET",
              buttonFunction: () => accept(widget.req.requestId),
            ),
            SizedBox(height: 10.0),
            Button(
              buttonColor: Colors.red,
              buttonText: "REDDET",
              buttonFunction: () => reject(widget.req.requestId),
            ),
          ],
        ),
      ),
    );
  }

  accept(reqId) {
    FireStoreService().editRequest(reqId);
    Navigator.pop(context);
  }

  reject(reqId) {
    FireStoreService().deleteRequest(reqId);
    Navigator.pop(context);
  }
}
