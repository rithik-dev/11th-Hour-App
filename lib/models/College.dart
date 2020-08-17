import 'package:flutter/cupertino.dart';

class College {
  String cid;
  String name;
  Map<String, dynamic> subjectWithCourses;

  College({
    @required this.cid,
    @required this.name,
    @required this.subjectWithCourses,
  });
}
