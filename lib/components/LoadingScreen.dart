import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color(0xffEEEEEE).withOpacity(0.5),
        child: SpinKitChasingDots(
          color: NeumorphicTheme.currentTheme(context).accentColor,
        ),
      ),
    );
  }
}
