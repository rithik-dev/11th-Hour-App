import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Course {
  String id;
  String title;
  List<String> lectureIds;
  String subject;
  String instructorName;
  double price;
  String instructorId;
  List<Map<String, dynamic>> lectures;
  Timestamp date;
  String collegeId;
  List<String> enrolledUsers;

  Course({
    @required this.id,
    @required this.collegeId,
    @required this.title,
    @required this.instructorName,
    @required this.price,
    @required this.lectures,
    @required this.date,
    @required this.enrolledUsers,
    @required this.subject,
  });
}
