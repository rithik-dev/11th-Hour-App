import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Course {
  String id;
  String title;
  String subject;
  String instructorName;
  int price;
  String instructorId;
  List<dynamic> lectures;
  Timestamp date;
  String collegeId;
  List<dynamic> enrolledUsers;

  Course({
    @required this.id,
    @required this.collegeId,
    @required this.title,
    @required this.instructorName,
    @required this.price,
    @required this.lectures,
    @required this.date,
    @required this.instructorId,
    @required this.enrolledUsers,
    @required this.subject,
  });

  @override
  String toString() {
    return 'Course{id: $id, title: $title, subject: $subject, instructorName: $instructorName, price: $price, instructorId: $instructorId, lectures: $lectures, date: $date, collegeId: $collegeId, enrolledUsers: $enrolledUsers}';
  }

  factory Course.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    return new Course(
      id: snapshot.documentID,
      title: snapshot['title'] as String,
      subject: snapshot['subject'] as String,
      instructorName: snapshot['instructorName'] as String,
      price: snapshot['price'] as int,
      instructorId: snapshot['instructorId'] as String,
      lectures: snapshot['lectures'] as List<dynamic>,
      date: snapshot['date'] as Timestamp,
      collegeId: snapshot['collegeId'] as String,
      enrolledUsers: snapshot['enrolledUsers'] as List<dynamic>,
    );
  }
}
