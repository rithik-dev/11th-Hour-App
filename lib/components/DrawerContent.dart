import 'package:eleventh_hour/controllers/UserController.dart';
import 'package:eleventh_hour/views/Home.dart';
import 'package:eleventh_hour/views/LoginScreen.dart';
import 'package:eleventh_hour/views/MyCoursesScreen.dart';
import 'package:eleventh_hour/views/MyUploadedCoursesScreen.dart';
import 'package:eleventh_hour/views/ProfileScreen.dart';
import 'package:eleventh_hour/views/WishlistScreen.dart';
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
          screenId != Home.id
              ? DrawerItem(
                  title: "Home",
                  icon: FontAwesomeIcons.bed,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.popAndPushNamed(context, Home.id);
                  },
                )
              : SizedBox.shrink(),
          screenId != ProfileScreen.id
              ? DrawerItem(
                  title: "Profile",
                  icon: FontAwesomeIcons.userCircle,
                  onTap: () {
                    if (screenId != Home.id) Navigator.pop(context);
                    Navigator.popAndPushNamed(context, ProfileScreen.id);
                  },
                )
              : SizedBox.shrink(),
          screenId != WishlistScreen.id
              ? DrawerItem(
                  title: "Wishlist",
                  icon: FontAwesomeIcons.heart,
                  onTap: () {
                    if (screenId != Home.id) Navigator.pop(context);
                    Navigator.popAndPushNamed(context, WishlistScreen.id);
                  },
                )
              : SizedBox.shrink(),
          screenId != MyCoursesScreen.id
              ? DrawerItem(
                  title: "My Courses",
                  icon: FontAwesomeIcons.video,
                  onTap: () {
                    if (screenId != Home.id) Navigator.pop(context);
                    Navigator.popAndPushNamed(context, MyCoursesScreen.id);
                  },
                )
              : SizedBox.shrink(),
          screenId != MyUploadedCoursesScreen.id
              ? DrawerItem(
                  title: "Uploaded Courses",
                  icon: FontAwesomeIcons.inbox,
                  onTap: () {
                    if (screenId != Home.id) Navigator.pop(context);
                    Navigator.popAndPushNamed(
                        context, MyUploadedCoursesScreen.id);
                  },
                )
              : SizedBox.shrink(),
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
                    if (screenId != Home.id) Navigator.pop(context);
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
        leading: FaIcon(icon),
        onTap: onTap,
        title: Text(title),
      ),
    );
  }
}
