import 'dart:typed_data';

import 'package:eleventh_hour/components/HomeBoilerPlate.dart';
import 'package:eleventh_hour/utilities/UiIcons.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NoCollegeScreen extends StatelessWidget {
  static const id = '/noCollegeScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        automaticallyImplyLeading: true,
        actions: [
          NeumorphicButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeBoilerPlate.id, (route) => false);
            },
            child: Icon(UiIcons.home),
          )
        ],
        title: NeumorphicText(
          "Spread the trend",
          style: NeumorphicStyle(color: Colors.black),
          textStyle: NeumorphicTextStyle(fontSize: 20),
        ),
      ),
      floatingActionButton: NeumorphicFloatingActionButton(
        child: Icon(UiIcons.share),
        style: NeumorphicTheme.currentTheme(context).buttonStyle,
        onPressed: () async {
          final ByteData bytes =
              await rootBundle.load('assets/images/marketing.jpeg');
          await Share.file(
              '11Hour', '11Hour', bytes.buffer.asUint8List(), 'image/jpeg',
              text: 'Hey Checkout this app.');
        },
        tooltip: "Spread!!",
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Text(
              "To get your college listed, just attract the toppers of your class with these perkss!!",
              style: NeumorphicTheme.currentTheme(context).textTheme.headline3,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Image.asset(
                'assets/images/marketing.jpeg',
              ),
            ),
//          NeumorphicCard(
//            margin: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
//            child: RaisedButton.icon(
//              label: Text("  Spread!!"),
//              color: NeumorphicTheme.currentTheme(context).baseColor,
//              elevation: 0,
//              onPressed: () {},
//              icon: Icon(UiIcons.share),
//            ),
//          )
          ],
        ),
      ),
    );
  }
}
