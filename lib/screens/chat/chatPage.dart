import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/models/message.dart';
import 'package:thepeti/models/user.dart';
import 'package:thepeti/services/authorizationService.dart';
import 'package:thepeti/services/fireStoreService.dart';
import 'package:thepeti/widgets/messageBubble.dart';

class ChatPage extends StatefulWidget {
  final User chattedUser;

  const ChatPage({Key key, this.chattedUser}) : super(key: key);
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.chattedUser.imageURL),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              widget.chattedUser.firstName,
              style: textBlackC,
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<Message>>(
                stream: FireStoreService().getMessages(
                    Provider.of<AuthorizationService>(context, listen: false)
                        .activeUserId,
                    widget.chattedUser.userId),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    controller: scrollController,
                    reverse: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return MessageBubble(
                        message: snapshot.data[index],
                        chattedUser: widget.chattedUser,
                      );
                    },
                  );
                },
              ),
            ),
            Container(height: 8.0, color: Colors.white),
            Container(
              padding: EdgeInsets.only(bottom: 8.0, left: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      cursorColor: primaryColor,
                      decoration: InputDecoration(
                        hintText: "MESAJINIZI YAZIN",
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(color: primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(color: primaryColor),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    child: FloatingActionButton(
                      elevation: 0,
                      backgroundColor: primaryColor,
                      child: Icon(
                        Icons.navigation,
                        size: 30.0,
                        color: Colors.white,
                      ),
                      onPressed: () => sendMessage(),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  sendMessage() async {
    if (messageController.text.trim().length > 0) {
      Message savedMessage = Message(
          senderId: Provider.of<AuthorizationService>(context, listen: false)
              .activeUserId,
          receiverId: widget.chattedUser.userId,
          isFromMe: true,
          message: messageController.text);
      bool result = await FireStoreService().saveMessage(savedMessage);
      if (result) {
        messageController.clear();
        scrollController.animateTo(0.0,
            duration: const Duration(milliseconds: 10), curve: Curves.easeOut);
      }
    }
  }
}
