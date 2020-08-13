import 'package:flutter/cupertino.dart';

class College {
  String cid;
  String name;
  Map<String, List<String>> subjectWithCourses;

  College({
    @required this.cid,
    @required this.name,
    @required this.subjectWithCourses,
  });
}
