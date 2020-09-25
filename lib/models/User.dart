import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class User extends ChangeNotifier {
  String name;
  String email;
  String profilePicURL;
  String phone;
  String collegeId;
  String userId;
  List<dynamic> transactionIds;
  List<dynamic> cart;
  List<dynamic> recentCoursesIds;
  List<dynamic> myCourses;
  List<dynamic> myUploadedCourses;
  List<dynamic> wishlist;

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
      transactionIds: snapshot['transactionIds'] as List<dynamic>,
      recentCoursesIds: snapshot['recentCoursesIds'] as List<dynamic>,
      cart: snapshot['cart'] as List<dynamic>,
      myCourses: snapshot['myCourses'] as List<dynamic>,
      myUploadedCourses: snapshot['myUploadedCourses'] as List<dynamic>,
      wishlist: snapshot['wishlist'] as List<dynamic>,
    );
  }

  void addCourseToRecentCourses(String courseId) {
    this.recentCoursesIds.add(courseId);
    notifyListeners();
  }

  void addCourseToWishlist(String courseId) {
    this.wishlist.add(courseId);
    notifyListeners();
  }

  void removeCourseFromWishlist(String courseId) {
    this.wishlist.remove(courseId);
    notifyListeners();
  }

  void addCourseToCart(String courseId) {
    this.cart.add(courseId);
    notifyListeners();
  }

  void removeCourseFromCart(String courseId) {
    this.cart.remove(courseId);
    notifyListeners();
  }

  void handleCheckoutFailure({String docId}) {
    this.transactionIds.add(docId);
    notifyListeners();
  }

  void handleCheckoutSuccess({String docId}) {
    this.cart.forEach((element) {
      this.myCourses.add(element);
    });
    this.transactionIds.add(docId);
    this.cart = [];
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
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
    };
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
