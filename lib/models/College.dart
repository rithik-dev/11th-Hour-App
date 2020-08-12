import 'package:flutter/cupertino.dart';

class College {
  String name;
  Map<String, List<String>> subjectWithCourses;

  College({
    @required this.name,
    @required this.subjectWithCourses,
  });
}
