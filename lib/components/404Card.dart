import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:lottie/lottie.dart';

class Card404 extends StatelessWidget {
  final String title;

  Card404({@required this.title});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Lottie.asset('assets/lottie/404.json'),
        Text(
          title != "UPLOADED COURSES"
              ? "\nTheir are no courses in your ${title.toLowerCase()}."
              : "\nTo Add a Course\nplease login from website.",
          style: NeumorphicTheme.currentTheme(context).textTheme.headline1,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
