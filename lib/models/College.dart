import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class College {
  String cid;
  String name;
  Map<String, dynamic> subjectWithCourses;

  @override
  String toString() {
    return 'College{cid: $cid, name: $name, subjectWithCourses: $subjectWithCourses}';
  }

  College({
    @required this.cid,
    @required this.name,
    @required this.subjectWithCourses,
  });

  factory College.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    return new College(
      cid: snapshot.documentID,
      name: snapshot['name'] as String,
      subjectWithCourses: snapshot['subjects'] as Map<String, dynamic>,
    );
  }
}
