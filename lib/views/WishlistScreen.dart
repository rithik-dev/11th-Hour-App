import 'package:eleventh_hour/components/404Card.dart';
import 'package:eleventh_hour/controllers/CourseController.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  static const id = '/wishlist';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer2<User, CourseController>(
            builder: (context, user, course, child) {
          if (user.wishlist == null || user.wishlist.length == 0)
            return Card404(title: "WISHLIST");
          else {
            return Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: ListView(
                      children: [Text("COurses")],
                    ),
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
