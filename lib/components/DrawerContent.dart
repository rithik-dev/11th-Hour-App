import 'package:eleventh_hour/controllers/UserController.dart';
import 'package:eleventh_hour/views/Home.dart';
import 'package:eleventh_hour/views/LoginScreen.dart';
import 'package:eleventh_hour/views/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DrawerItem(
            title: "Home",
            icon: FontAwesomeIcons.bed,
            onTap: () {
              Navigator.pop(context);
              Navigator.popAndPushNamed(context, Home.id);
            },
          ),
          DrawerItem(
            title: "Profile",
            icon: FontAwesomeIcons.userCircle,
            onTap: () {
              Navigator.popAndPushNamed(context, ProfileScreen.id);
            },
          ),
          DrawerItem(
            title: "Compose",
            icon: FontAwesomeIcons.penFancy,
            onTap: () {
//              Navigator.pushNamed(context, EditStoryScreen.id, arguments: user);
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
        contentPadding: EdgeInsets.all(30),
        leading: FaIcon(icon),
        onTap: onTap,
        title: Text(title),
      ),
    );
  }
}
