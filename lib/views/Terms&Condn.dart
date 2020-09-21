import 'package:eleventh_hour/components/CollapsingTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class TermsAndCondition extends StatelessWidget {
  static const id = '/terms';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: Text("Terms And Conditions"),
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
