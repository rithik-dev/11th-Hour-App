import 'package:eleventh_hour/models/Course.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseDetails extends StatelessWidget {
  final Course course;
  CourseDetails({this.course});
  static const id = '/details';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<User>(
          builder: (context, user, child) {
            return Text(
              course.title,
              style: Theme.of(context).textTheme.headline1,
            );
          },
        ),
      ),
    );
  }
}
