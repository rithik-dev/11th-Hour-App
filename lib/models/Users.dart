import 'package:flutter/cupertino.dart';

class User extends ChangeNotifier {
  String name;
  String email;
  String profileURL;
  String phone;
  String collegeId;
  String userId;
  List<String> myCourses;
  List<String> myUploadedCourses;
  List<String> wishlist;

  User({
    @required this.name,
    @required this.email,
    @required this.profileURL,
    @required this.phone,
    @required this.collegeId,
    @required this.userId,
    @required this.myCourses,
    @required this.myUploadedCourses,
    @required this.wishlist,
  });
}
