import 'package:eleventh_hour/components/404Card.dart';
import 'package:eleventh_hour/components/DrawerBoilerPlate.dart';
import 'package:eleventh_hour/components/SmallCourseCard.dart';
import 'package:eleventh_hour/controllers/CourseController.dart';
import 'package:eleventh_hour/controllers/UserController.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class MyUploadedCoursesScreen extends StatelessWidget {
  static const id = '/my_uploaded_courses';
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  void toggle() {
    _innerDrawerKey.currentState.toggle(direction: InnerDrawerDirection.start);
  }

  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
      screenId: MyUploadedCoursesScreen.id,
      innerDrawerKey: _innerDrawerKey,
      scaffold: Scaffold(
        appBar: NeumorphicAppBar(
          leading: NeumorphicButton(
            onPressed: () {
              toggle();
            },
            child: Icon(Icons.filter_list),
          ),
          title: Text("MY UPLOADED COURSES"),
        ),
        body: Consumer2<User, CourseController>(
            builder: (context, user, courses, child) {
          return RefreshIndicator(
            onRefresh: () async {
              final User newUser = await UserController.getUser(user.userId);
              Provider.of<User>(context, listen: false)
                  .updateUserInProvider(newUser);
            },
            child: (user.myUploadedCourses == null ||
                    user.myUploadedCourses.length == 0)
                ? Card404(
                    desc:
                        "The best revision is teaching others.\n Start teaching!\n \nVisit website to upload your first course.")
                : Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: ListView(
                            children: courses
                                .getCoursesByIds(
                                    user.myUploadedCourses.cast<String>())
                                .map((course) => SmallCourseCard(
                                      course: course,
                                    ))
                                .toList(),
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
