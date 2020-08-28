import 'package:eleventh_hour/models/Course.dart';
import 'package:flutter/material.dart';

class CourseProvider extends ChangeNotifier {
  List<Course> courses;

  CourseProvider({@required this.courses});
}
