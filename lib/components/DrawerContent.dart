import 'package:eleventh_hour/controllers/UserController.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:eleventh_hour/views/Home.dart';
import 'package:eleventh_hour/views/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerContent extends StatelessWidget {
  final User user;
  DrawerContent({this.user});
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
              Navigator.pushNamed(context, Home.id);
            },
          ),
          DrawerItem(
            title: "Profile",
            icon: FontAwesomeIcons.userCircle,
            onTap: () {
//              Navigator.pushNamed(context, ProfileScreen.id, arguments: User);
            },
          ),
          DrawerItem(
            title: "Compose",
            icon: FontAwesomeIcons.penFancy,
            onTap: () {
//              Navigator.pushNamed(context, EditStoryScreen.id, arguments: user);
            },
          ),
          SizedBox(
            height: 20,
          ),
          DrawerItem(
              title: "Sign Out",
              icon: FontAwesomeIcons.signOutAlt,
              onTap: () async {
                await UserController.logoutUser();
                Navigator.popAndPushNamed(context, LoginScreen.id);
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
        focusColor: Colors.transparent,
        contentPadding: EdgeInsets.all(30),
        leading: FaIcon(icon),
        onTap: onTap,
        title: Text(title),
      ),
    );
  }
}
