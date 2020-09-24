import 'package:eleventh_hour/components/DrawerBoilerPlate.dart';
import 'package:eleventh_hour/components/HomeBoilerPlate.dart';
import 'package:eleventh_hour/components/NeumoCard.dart';
import 'package:eleventh_hour/utilities/UiIcons.dart';
import 'package:eleventh_hour/views/AboutUs.dart';
import 'package:eleventh_hour/views/RefundPolicy.dart';
import 'package:eleventh_hour/views/Terms&Condn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoAndSupport extends StatelessWidget {
  static const id = 'info_and_support';

  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  void toggle() {
    _innerDrawerKey.currentState.toggle(direction: InnerDrawerDirection.start);
  }

  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
      screenId: InfoAndSupport.id,
      innerDrawerKey: _innerDrawerKey,
      scaffold: Scaffold(
        appBar: NeumorphicAppBar(
          actions: [
            NeumorphicButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, HomeBoilerPlate.id, (route) => false);
              },
              child: Icon(UiIcons.home),
            )
          ],
          leading: NeumorphicButton(
            onPressed: () {
              toggle();
            },
            child: Icon(Icons.filter_list),
          ),
          title: NeumorphicText(
            "Info & Support",
            style: NeumorphicStyle(color: Colors.black),
            textStyle: NeumorphicTextStyle(fontSize: 20),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AboutUs.id);
                  },
                  child: NeumorphicCard(
                    padding: EdgeInsets.all(30),
                    child: Text(
                      "About Us",
                      textAlign: TextAlign.center,
                      style: NeumorphicTheme.currentTheme(context)
                          .textTheme
                          .headline1,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, TermsAndCondition.id);
                  },
                  child: NeumorphicCard(
                    padding: EdgeInsets.all(30),
                    child: Text(
                      "Terms & Conditions",
                      textAlign: TextAlign.center,
                      style: NeumorphicTheme.currentTheme(context)
                          .textTheme
                          .headline1,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RefundPolicies.id);
                  },
                  child: NeumorphicCard(
                    padding: EdgeInsets.all(30),
                    child: Text(
                      "Refund Policy",
                      textAlign: TextAlign.center,
                      style: NeumorphicTheme.currentTheme(context)
                          .textTheme
                          .headline1,
                    ),
                  ),
                ),
              ],
            ),
            NeumorphicCard(
              child: Column(
                children: [
                  Text(
                    "\nContact Us",
                    style: NeumorphicTheme.currentTheme(context)
                        .textTheme
                        .headline2,
                  ),
                  RaisedButton.icon(
                    highlightColor:
                        NeumorphicTheme.currentTheme(context).baseColor,
                    padding: EdgeInsets.all(30),
                    elevation: 0,
                    color: NeumorphicTheme.currentTheme(context).baseColor,
                    onPressed: () async {
                      if (await canLaunch(
                          "mailto:company.eleventhhour@gmail.com")) {
                        await launch("mailto:company.eleventhhour@gmail.com");
                      } else {
                        throw 'Could not launch';
                      }
                    },
                    icon: Icon(Icons.contact_mail),
                    label: Text(
                      "company.eleventhhour@gmail.com",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
