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

  void addUserToCourses({String userId, List<String> courseIds}) {
    for (String courseId in courseIds)
      this.getCourseByID(courseId).enrolledUsers.add(userId);
    notifyListeners();
  }

  Future updateCourseRating({String courseId, Map newRating}) async {
    await Firestore.instance
        .collection("courses")
        .document(courseId)
        .updateData({
      "ratings": FieldValue.arrayUnion([newRating])
    });
    for (int i = 0; i < this.courses.length; i++) {
      if (this.courses[i].id == courseId) {
        if (this.courses[i].ratings == null) this.courses[i].ratings = [];
        this.courses[i].ratings.add(newRating);
        break;
      }
    }
//    for (Course c in this.courses) {
//      if (c.id == courseId) {
//        if (c.ratings == null) c.ratings = [];
//        c.ratings.add(newRating);
//        break;
//      }
//    }
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

    try {
      print(courseIds);
      for (String courseId in courseIds) {
        var cid = getCourseByID(courseId.trim());
        _courses.add(cid);
      }
    } catch (err) {
      print(err);
    }
//    print("lol $_courses");
    return _courses;
  }
}
