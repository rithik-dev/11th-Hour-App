import 'package:eleventh_hour/controllers/CourseController.dart';
import 'package:eleventh_hour/controllers/UserController.dart';
import 'package:eleventh_hour/models/College.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubjectDetails extends StatelessWidget {
  static const id = '/subject_details';

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer3<User, College, CourseController>(
            builder: (context, user, college, course, child) {
          return RefreshIndicator(
            onRefresh: () async {
              final User newUser = await UserController.getUser(user.userId);
              Provider.of<User>(context, listen: false)
                  .updateUserInProvider(newUser);
            },
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: ListView(
                      children: [Text("sibjet")],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
