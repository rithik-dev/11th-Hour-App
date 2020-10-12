import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CollapsingTile extends StatelessWidget {
  final String question;
  final String answer;

  CollapsingTile({this.question, this.answer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        initiallyExpanded: false,
        childrenPadding: EdgeInsets.all(20),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.hashtag,
              size: 17,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(question,
                  softWrap: true,
                  style: NeumorphicTheme.currentTheme(context)
                      .textTheme
                      .headline5),
            )
          ],
        ),
        children: [
          Text(
            answer,
            softWrap: true,
            style: NeumorphicTheme.currentTheme(context)
                .textTheme
                .headline5
                .copyWith(color: Colors.grey[900]),
          ),
        ],
      ),
    );
  }
}
