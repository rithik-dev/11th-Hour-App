import 'package:flutter/material.dart';
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              FontAwesomeIcons.solidQuestionCircle,
              size: 17,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(question,
                  softWrap: true, style: Theme.of(context).textTheme.headline5),
            )
          ],
        ),
        children: [
          Row(
            children: [
              Icon(
                FontAwesomeIcons.flask,
                size: 17,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  answer,
                  softWrap: true,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Colors.grey[900]),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
