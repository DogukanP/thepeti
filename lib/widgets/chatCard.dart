import 'package:flutter/material.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/models/chat.dart';
import 'package:thepeti/models/user.dart';
import 'package:thepeti/screens/chat/chatPage.dart';

class ChatCard extends StatefulWidget {
  final User user;
  final Chat chat;

  const ChatCard({Key key, this.user, this.chat}) : super(key: key);
  @override
  _ChatCardState createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ChatPage(
              chattedUser: widget.user,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25.0, 8.0, 25.0, 8.0),
        child: Container(
          height: 85.0,
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
          child: Center(
            child: ListTile(
              title: Text(
                widget.user.firstName,
                style: text18,
              ),
              leading: CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(widget.user.imageURL),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
