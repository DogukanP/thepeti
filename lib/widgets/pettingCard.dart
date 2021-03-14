import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/models/petting.dart';
import 'package:thepeti/models/user.dart';

class PettingCard extends StatefulWidget {
  final Petting petting;
  final User user;

  const PettingCard({Key key, this.petting, this.user}) : super(key: key);
  @override
  _PettingCardState createState() => _PettingCardState();
}

class _PettingCardState extends State<PettingCard> {
  DateFormat formatter = DateFormat('dd/MM/yyyy');
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "ONAY BEKLENİYOR",
                          style: textPrimaryC,
                        )
                      ],
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
                                    backgroundImage:
                                        widget.user.imageURL.isNotEmpty
                                            ? NetworkImage(widget.user.imageURL)
                                            : AssetImage(
                                                "assets/profile_photo.png")),
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
                )),
          ],
        ),
      ),
    );
  }
}
