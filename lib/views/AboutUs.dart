import 'package:eleventh_hour/components/CollapsingTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AboutUs extends StatelessWidget {
  static const id = '/about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: Text("About Us"),
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          children: [
            CollapsingTile(
              question: "Who is DP",
              answer: "Lord",
            )
          ],
        ),
      ),
    );
  }
}
