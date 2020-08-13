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
    this.myCourses,
    this.myUploadedCourses,
    this.wishlist,
  });
  void updatePersonalDetails(
      {String name,
      String collegeId,
      String profileURL,
      String phone,
      String email}) {
    this.name = name;
    this.collegeId = collegeId;
    this.email = email;
    this.profileURL = profileURL;
    this.phone = phone;
    notifyListeners();
  }
}
