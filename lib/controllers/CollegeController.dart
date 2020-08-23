import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eleventh_hour/models/College.dart';

class CollegeController {
  CollegeController._();

  static final Firestore _firestore = Firestore.instance;

  static Future<List<College>> getColleges() async {
    List<College> colleges = [];
    QuerySnapshot snapshot =
        await _firestore.collection("colleges").orderBy('name').getDocuments();

    for (DocumentSnapshot college in snapshot.documents) {
      colleges.add(College.fromDocumentSnapshot(college));
    }
    return colleges;
  }

  static Future<College> getCollegeFromId(String id) async {
    DocumentSnapshot snapshot =
        await _firestore.collection("colleges").document(id).get();

    College college = College.fromDocumentSnapshot(snapshot);

    return college;
  }
}
