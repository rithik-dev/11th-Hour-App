import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eleventh_hour/models/College.dart';

class CollegeController {
  CollegeController._();

  static Future<List<College>> getColleges() async {
    List<College> colleges = [];
    QuerySnapshot snapshot = await Firestore.instance
        .collection("colleges")
        .orderBy('name')
        .getDocuments();

    for (DocumentSnapshot college in snapshot.documents) {
      colleges.add(
        new College(
          name: college.data['name'],
          cid: college.documentID,
          subjectWithCourses: college.data['subjects'],
        ),
      );
    }
    return colleges;
  }
}
