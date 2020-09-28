import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class College extends ChangeNotifier {
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

  void updateCollegeInProvider(College college) {
    this.name = college.name;
    this.cid = college.cid;
    this.subjectWithCourses = college.subjectWithCourses;
    notifyListeners();
  }

  factory College.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    return new College(
      cid: snapshot.documentID,
      name: snapshot['name'] as String,
      subjectWithCourses:
          snapshot['subjectWithCourses'] as Map<String, dynamic>,
    );
  }
}
