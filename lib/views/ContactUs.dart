import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  static const id = '/contact';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: RaisedButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    color: Colors.black.withOpacity(0.537),
                    height: 240,
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(25.0),
                            topRight: const Radius.circular(25.0),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Text(
                                "Select",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ListTile(
                              onTap: () async {
                                await launch("tel://9897699041");
                              },
                              title: Text(
                                "9897699041",
                                style: NeumorphicTheme.currentTheme(context)
                                    .textTheme
                                    .headline4
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              leading: Icon(
                                FontAwesomeIcons.phoneAlt,
                                size: 20,
                                color: NeumorphicTheme.currentTheme(context)
                                    .accentColor,
                              ),
                            ),
                            ListTile(
                              title: Text(
                                "9958869248",
                                style: NeumorphicTheme.currentTheme(context)
                                    .textTheme
                                    .headline4
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              onTap: () async {
                                await launch("tel://9958869248");
                              },
                              leading: Icon(
                                FontAwesomeIcons.phoneAlt,
                                size: 20,
                                color: NeumorphicTheme.currentTheme(context)
                                    .accentColor,
                              ),
                            ),
                            ListTile(
                              title: Text(
                                "9953798220",
                                style: NeumorphicTheme.currentTheme(context)
                                    .textTheme
                                    .headline4
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              onTap: () async {
                                await launch("tel://9953798220");
                              },
                              leading: Icon(
                                FontAwesomeIcons.phoneAlt,
                                size: 20,
                                color: NeumorphicTheme.currentTheme(context)
                                    .accentColor,
                              ),
                            ),
                          ],
                        )),
                  );
                });
          },
          color: NeumorphicTheme.currentTheme(context)
              .accentColor
              .withOpacity(0.9),
          child: Text(
            "Contact Us",
            style: NeumorphicTheme.currentTheme(context).textTheme.headline4,
          )),
    );
  }
}
