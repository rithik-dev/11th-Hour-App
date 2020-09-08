import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Course {
  String id;
  double rating;
  String title;
  bool blackListed;
  String subject;
  String instructorName;
  int price;
  String instructorId;
  String courseThumbnail;
  List<dynamic> lectures;
  Timestamp date;
  String collegeId;
  List<dynamic> enrolledUsers;
  String description;

  Course(
      {@required this.id,
      @required this.collegeId,
      @required this.blackListed,
      @required this.description,
      @required this.title,
      @required this.rating,
      @required this.instructorName,
      @required this.price,
      @required this.lectures,
      @required this.date,
      @required this.instructorId,
      @required this.enrolledUsers,
      @required this.subject,
      @required this.courseThumbnail});

  @override
//  String toString() {
//    return 'Course{id: $id, description : $description ,title: $title, blackListed: $blackListed,rating $rating, subject: $subject, instructorName: $instructorName, price: $price, instructorId: $instructorId, lectures: $lectures, date: $date, collegeId: $collegeId, enrolledUsers: $enrolledUsers}';
//  }

  factory Course.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    return new Course(
      blackListed: snapshot['blackListed'] as bool,
      id: snapshot.documentID,
      description: snapshot['description'] as String,
      rating: snapshot['rating'] as double,
      title: snapshot['title'] as String,
      subject: snapshot['subject'] as String,
      courseThumbnail: snapshot['courseThumbnail'] as String,
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
