import 'package:eleventh_hour/controllers/UserController.dart';
import 'package:eleventh_hour/views/LoginScreen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static const id = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await UserController.logoutUser();
              Navigator.popAndPushNamed(context, LoginScreen.id);
            },
          )
        ],
      ),
    );
  }
}
