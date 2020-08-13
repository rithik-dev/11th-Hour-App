import 'package:eleventh_hour/views/LoginScreen.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  static const id = '/intro';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FlatButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, LoginScreen.id);
          },
          child: Text("Go"),
        ),
      ),
    );
  }
}
