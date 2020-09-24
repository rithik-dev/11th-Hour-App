import 'package:eleventh_hour/components/CollapsingTile.dart';
import 'package:eleventh_hour/components/HomeBoilerPlate.dart';
import 'package:eleventh_hour/utilities/UiIcons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class RefundPolicies extends StatelessWidget {
  static const id = '/refund_policies';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: Text("Refund Policies"),
        actions: [
          NeumorphicButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeBoilerPlate.id, (route) => false);
            },
            child: Icon(UiIcons.home),
          )
        ],
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
