import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:lottie/lottie.dart';

class Card404 extends StatelessWidget {
  final String desc;
  Card404({@required this.desc});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10),
      children: [
        Lottie.asset('assets/lottie/404.json'),
        Text(
          desc,
          style: NeumorphicTheme.currentTheme(context).textTheme.headline1,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
