import 'package:eleventh_hour/components/SmallCourseCard.dart';
import 'package:eleventh_hour/controllers/CollegeController.dart';
import 'package:eleventh_hour/controllers/CourseController.dart';
import 'package:eleventh_hour/models/College.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class SubjectDetails extends StatelessWidget {
  static const id = '/subject_details';
  final String subject;
  SubjectDetails({this.subject});
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: Text(
          subject,
          style: Theme.of(context).textTheme.headline4,
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Consumer3<User, College, CourseController>(
            builder: (context, user, college, course, child) {
          return RefreshIndicator(
            onRefresh: () async {
              final College newCollege =
                  await CollegeController.getCollegeFromId(user.collegeId);
              Provider.of<College>(context, listen: false)
                  .updateCollegeInProvider(newCollege);
            },
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: ListView(
                      children: course
                          .getCoursesByIds(college.subjectWithCourses[subject]
                              .cast<String>())
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
