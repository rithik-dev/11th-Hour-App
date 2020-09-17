import 'package:eleventh_hour/utilities/UiIcons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:share/share.dart';

class NoCollegeScreen extends StatelessWidget {
  static const id = '/noCollegeScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        automaticallyImplyLeading: true,
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
//          Directory appDocDir = await getApplicationDocumentsDirectory();
//          String appDocPath = appDocDir.path;
//          Directory tempDir = await getExternalStorageDirectory();
//          String tempPath = tempDir.path;
//          String path = "$tempPath/images/marketting.jpeg";
//          print(path);
          Share.share(
              "Yeh image hi share hogi,baad me abhi ni hogi frnads...dont share please");
//          Share.shareFiles(['$path'], text: "Hey checkout this app 11th Hour");
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
                'assets/images/marketting.jpeg',
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
