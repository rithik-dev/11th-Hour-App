import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Course {
  String id;
  String title;
  List<String> lecturesId;
  String subject;
  String instructorName;
  double price;
  Timestamp date;
  List<String> enrolledUsers;

  Course({
    @required this.id,
    @required this.title,
    @required this.instructorName,
    @required this.price,
    @required this.date,
    @required this.enrolledUsers,
    @required this.subject,
  });
}
