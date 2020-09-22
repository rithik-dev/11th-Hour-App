import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color color;
  NeumorphicCard(
      {@required this.child,
      this.margin = const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      this.color = const Color(0xffEEEEEE),
      this.padding = const EdgeInsets.all(0)});
  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        intensity: 0.5,
        shape: NeumorphicShape.convex,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
        depth: 4,
        surfaceIntensity: 0,
        shadowLightColor: NeumorphicTheme.currentTheme(context).accentColor,
//          shadowDarkColor: NeumorphicTheme.currentTheme(context).accentColor,
        lightSource: LightSource.top,
        color: color,
      ),
      margin: margin,
      padding: padding,
      child: child,
    );
  }
}
