import 'package:flutter/material.dart';

class Card404 extends StatelessWidget {
  final String title;

  Card404({@required this.title});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[Text("NO ${this.title} found.")],
    );
  }
}
