import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SlimyTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Top",
      style: NeumorphicTheme.currentTheme(context).textTheme.headline1,
    );
  }
}
