import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/models/chat.dart';
import 'package:thepeti/models/user.dart';
import 'package:thepeti/services/authorizationService.dart';
import 'package:thepeti/services/fireStoreService.dart';
import 'package:thepeti/widgets/chatCard.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    String activeUserId =
        Provider.of<AuthorizationService>(context, listen: false).activeUserId;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "SOHBETLER",
          style: textBlackC,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
        child: FutureBuilder<List<Chat>>(
          future: FireStoreService().getChats(activeUserId),
          builder: (context, chatlist) {
            if (!chatlist.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var allChats = chatlist.data;
              if (allChats.length > 0) {
                return RefreshIndicator(
                  onRefresh: refresh,
                  child: ListView.builder(
                    itemCount: allChats.length,
                    itemBuilder: (context, index) {
                      Chat chat = allChats[index];
                      return FutureBuilder<User>(
                        future: FireStoreService().getUser(chat.receiver),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          User user = snapshot.data;
                          return ChatCard(
                            chat: chat,
                            user: user,
                          );
                        },
                      );
                    },
                  ),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.chat,
                      color: primaryColor,
                      size: 100.0,
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Text(
                      "HERHANGİ BİR SOHBETİN YOK",
                      style: text40,
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              }
            }
          },
        ),
      ),
    );
  }

  Future<Null> refresh() async {
    setState(() {});
    await Future.delayed(Duration(seconds: 1));
    return null;
  }
}
