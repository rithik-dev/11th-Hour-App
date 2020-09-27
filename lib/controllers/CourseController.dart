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

  Future updateCourseRating(
      {String courseId, Map newRating, String userId}) async {
    final DocumentSnapshot snapshot =
        await Firestore.instance.collection("courses").document(courseId).get();

    List ratings = snapshot['ratings'];

    if (ratings == null || ratings.length == 0)
      ratings = [newRating];
    else {
      bool isRated = false;
      for (int i = 0; i < ratings.length; i++) {
        if (ratings[i]['userId'] == userId) {
          ratings[i]['userRating'] = newRating['userRating'];
          isRated = true;
          break;
        }
      }
      if (!isRated) {
        ratings.add(newRating);
      }
    }

    await Firestore.instance
        .collection("courses")
        .document(courseId)
        .updateData({"ratings": ratings});
    for (int i = 0; i < this.courses.length; i++) {
      if (this.courses[i].id == courseId) {
        this.courses[i].ratings = ratings;
        print("ratingggg ${this.courses[i].ratings}");
        break;
      }
    }
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

    return _courses;
  }

  List<Course> getCoursesByIds(List<String> courseIds) {
    List<Course> _courses = [];

    try {
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
