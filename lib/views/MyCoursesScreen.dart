import 'package:eleventh_hour/components/404Card.dart';
import 'package:eleventh_hour/components/SmallCourseCard.dart';
import 'package:eleventh_hour/controllers/CourseController.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCoursesScreen extends StatelessWidget {
  static const id = '/my_courses';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer2<User, CourseController>(
            builder: (context, user, courses, child) {
          if (user.myCourses == null || user.myCourses.length == 0)
            return Card404(desc: "You don't have any course!!");
          else {
            return Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: ListView(
                      children: courses
                          .getCoursesByIds(user.myCourses.cast<String>())
                          .map((course) => SmallCourseCard(
                                course: course,
                              ))
                          .toList(),
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
