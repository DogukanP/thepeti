// ignore: implementation_imports
import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/models/message.dart';
import 'package:thepeti/models/user.dart';

class MessageBubble extends StatefulWidget {
  final Message message;
  final User chattedUser;
  const MessageBubble({Key key, this.message, this.chattedUser})
      : super(key: key);
  @override
  _MessageBubbleState createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  @override
  Widget build(BuildContext context) {
    Color inComingMsgColor = Colors.grey;
    Color outGoingMsgColor = primaryColor;
    var date = " ";
    try {
      date = dateFormat(widget.message.createdDate ?? Timestamp(1, 1));
    } catch (e) {
      print("hata var" + e.toString());
    }

    var isFromMe = widget.message.isFromMe;
    if (isFromMe) {
      return Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(4.0),
                    child: Text(
                      widget.message.message,
                      style: textWhite18,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: outGoingMsgColor,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              date,
              style: text13,
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.chattedUser.imageURL),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(4.0),
                    child: Text(
                      widget.message.message,
                      style: textWhite18,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: inComingMsgColor,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              date,
              textAlign: TextAlign.end,
              style: text13,
            ),
          ],
        ),
      );
    }
  }

  String dateFormat(Timestamp createdDate) {
    var formatter = DateFormat.Hm();
    var formattedDate = formatter.format(createdDate.toDate());
    return formattedDate;
  }
}
