import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:thepeti/constants.dart';
import 'package:thepeti/notificationHandler.dart';
import 'package:thepeti/screens/beKeeper/beKeeper.dart';
import 'package:thepeti/screens/homeScreens/pettingScreen.dart';
import 'package:thepeti/screens/searchKeeper/searchKeeper.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  int activePageNumber = 0;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    NotificationHandler().initializeFCMNotification(context);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (openPageNumber) {
          setState(() {
            activePageNumber = openPageNumber;
          });
        },
        controller: pageController,
        children: [
          PettingScreen(),
          SearchKeeper(),
          BeKeeper(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: activePageNumber,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 32), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, size: 32), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline, size: 32), label: ""),
        ],
        onTap: (selectedPageNumber) {
          setState(() {
            pageController.jumpToPage(selectedPageNumber);
          });
        },
      ),
    );
  }
}
