import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class User extends ChangeNotifier {
  String name;
  String email;
  String profilePicURL;
  String phone;
  String collegeId;
  String userId;
  List<String> transactionIds;
  List<String> cart;
  List<String> recentCoursesIds;
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
    this.recentCoursesIds,
    this.cart,
    this.myCourses,
    this.myUploadedCourses,
    this.wishlist,
  });

  factory User.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    return new User(
      name: snapshot['name'] as String,
      email: snapshot['email'] as String,
      profilePicURL: snapshot['profilePicURL'] as String,
      phone: snapshot['phone'] as String,
      collegeId: snapshot['collegeId'] as String,
      userId: snapshot.documentID,
      transactionIds: snapshot['transactionIds'] as List<String>,
      recentCoursesIds: snapshot['recentCoursesIds'] as List<String>,
      cart: snapshot['cart'] as List<String>,
      myCourses: snapshot['myCourses'] as List<String>,
      myUploadedCourses: snapshot['myUploadedCourses'] as List<String>,
      wishlist: snapshot['wishlist'] as List<String>,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'name': this.name,
      'email': this.email,
      'profilePicURL': this.profilePicURL,
      'phone': this.phone,
      'collegeId': this.collegeId,
      'userId': this.userId,
      'transactionIds': this.transactionIds,
      'myCourses': this.myCourses,
      'recentCoursesIds': this.recentCoursesIds,
      'cart': this.cart,
      'myUploadedCourses': this.myUploadedCourses,
      'wishlist': this.wishlist,
    } as Map<String, dynamic>;
  }

  @override
  String toString() {
    return 'User{name: $name, email: $email, profilePicURL: $profilePicURL, phone: $phone, collegeId: $collegeId, userId: $userId, transactionIds: $transactionIds, myCourses: $myCourses, myUploadedCourses: $myUploadedCourses, wishlist: $wishlist, recentCoursesIds: $recentCoursesIds , cart: $cart}';
  }

  void updateUserInProvider(User user) {
    this.name = user.name;
    this.email = user.email;
    this.profilePicURL = user.profilePicURL;
    this.phone = user.phone;
    this.collegeId = user.collegeId;
    this.userId = user.userId;
    this.transactionIds = user.transactionIds;
    this.myCourses = user.myCourses;
    this.myUploadedCourses = user.myUploadedCourses;
    this.wishlist = user.wishlist;
    this.recentCoursesIds = user.recentCoursesIds;
    this.cart = user.cart;
    notifyListeners();
  }
}
