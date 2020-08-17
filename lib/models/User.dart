import 'package:flutter/cupertino.dart';

class User extends ChangeNotifier {
  String name;
  String email;
  String profilePicURL;
  String phone;
  String collegeId;
  String userId;
  List<String> transactionIds;
  List<String> myCourses;
  List<String> myUploadedCourses;
  List<String> wishlist;

  User({
    @required this.name,
    @required this.email,
    @required this.profilePicURL,
    @required this.phone,
    @required this.collegeId,
    @required this.userId,
    this.transactionIds,
    this.myCourses,
    this.myUploadedCourses,
    this.wishlist,
  });

  void updatePersonalDetails(
      {String name,
      String collegeId,
      String profilePicURL,
      String phone,
      String email}) {
    this.name = name;
    this.collegeId = collegeId;
    this.email = email;
    this.profilePicURL = profilePicURL;
    this.phone = phone;
    notifyListeners();
  }
}
