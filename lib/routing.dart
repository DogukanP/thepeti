import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thepeti/models/user.dart';
import 'package:thepeti/screens/homeScreen.dart';
import 'package:thepeti/screens/loginPage.dart';
import 'package:thepeti/services/authorizationService.dart';

class Routing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authorizationService =
        Provider.of<AuthorizationService>(context, listen: false);

    return StreamBuilder(
      stream: authorizationService.statusControl,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasData) {
          User activeUser = snapshot.data;
          authorizationService.activeUserId = activeUser.userId;
          return HomeScreen();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
