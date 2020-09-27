import 'package:eleventh_hour/components/HomeBoilerPlate.dart';
import 'package:eleventh_hour/controllers/UserController.dart';
import 'package:eleventh_hour/utilities/UiIcons.dart';
import 'package:eleventh_hour/views/InfoAndSupport.dart';
import 'package:eleventh_hour/views/LoginScreen.dart';
import 'package:eleventh_hour/views/MyUploadedCoursesScreen.dart';
import 'package:eleventh_hour/views/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerContent extends StatelessWidget {
  final String screenId;

  DrawerContent({@required this.screenId});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          screenId != ProfileScreen.id
              ? DrawerItem(
                  title: "Profile",
                  icon: FontAwesomeIcons.userCircle,
                  onTap: () {
                    if (screenId != HomeBoilerPlate.id) Navigator.pop(context);
                    Navigator.popAndPushNamed(context, ProfileScreen.id);
                  },
                )
              : DrawerItem(
                  title: "Home",
                  icon: UiIcons.home,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.popAndPushNamed(context, HomeBoilerPlate.id);
                  },
                ),
          screenId != MyUploadedCoursesScreen.id
              ? DrawerItem(
                  title: "Uploaded Courses",
                  icon: FontAwesomeIcons.inbox,
                  onTap: () {
                    if (screenId != HomeBoilerPlate.id) Navigator.pop(context);
                    Navigator.popAndPushNamed(
                        context, MyUploadedCoursesScreen.id);
                  },
                )
              : DrawerItem(
                  title: "Home",
                  icon: UiIcons.home,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.popAndPushNamed(context, HomeBoilerPlate.id);
                  },
                ),
          screenId != InfoAndSupport.id
              ? DrawerItem(
                  title: "Info and Support",
                  icon: FontAwesomeIcons.infoCircle,
                  onTap: () {
                    if (screenId != HomeBoilerPlate.id) Navigator.pop(context);
                    Navigator.popAndPushNamed(context, InfoAndSupport.id);
                  },
                )
              : DrawerItem(
                  title: "Home",
                  icon: UiIcons.home,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.popAndPushNamed(context, HomeBoilerPlate.id);
                  },
                ),
          DrawerItem(
              title: "Sign Out",
              icon: FontAwesomeIcons.signOutAlt,
              onTap: () async {
                try {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.remove('userId');
                  final bool success = await UserController.logoutUser();
                  if (success) {
                    if (screenId != HomeBoilerPlate.id) Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.popAndPushNamed(context, LoginScreen.id);
                  } else {
                    Navigator.pop(context);
                    Fluttertoast.showToast(msg: "Failed To Logout User !");
                  }
                } catch (e) {
                  Navigator.pop(context);
                  Fluttertoast.showToast(msg: "Failed To Logout User !");
                }
              }),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;

  DrawerItem({this.onTap, this.icon, this.title});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      child: ListTile(
        contentPadding: EdgeInsets.all(20),
        leading: FaIcon(
          icon,
          color: Colors.white,
        ),
        onTap: onTap,
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline3
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
