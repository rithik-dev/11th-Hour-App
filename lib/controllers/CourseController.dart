import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eleventh_hour/models/Course.dart';
import 'package:flutter/material.dart';

class CourseController extends ChangeNotifier {
  List<Course> courses;

  CourseController({@required this.courses});

  Future<void> getCourses() async {
    List<Course> _courses = [];
    QuerySnapshot snapshot =
        await Firestore.instance.collection("courses").getDocuments();
    snapshot.documents.forEach((course) {
      _courses.add(Course.fromDocumentSnapshot(course));
    });
    this.courses = _courses;
    notifyListeners();
  }

  Course getCourseByID(String courseId) {
    return this.courses.where((course) => course.id == courseId).first;
  }

  List<Course> getTrendingCourses() {
    List<Course> _courses = this.courses;
    _courses.sort((a, b) {
      return b.enrolledUsers.length.compareTo(a.enrolledUsers.length);
    });
    if (_courses.length > 5)
      return _courses.sublist(0, 5);
    else
      return _courses;
  }

  List<Course> getCoursesByIds(List<String> courseIds) {
    List<Course> _courses = [];

    for (String courseId in courseIds) {
      _courses.add(getCourseByID(courseId));
    }
    return _courses;
  }
}
