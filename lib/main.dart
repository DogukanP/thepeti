import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thepeti/routing.dart';
import 'package:thepeti/services/authorizationService.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthorizationService>(
      create: (_) => AuthorizationService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Routing(),
      ),
    );
  }
}
