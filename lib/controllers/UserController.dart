import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eleventh_hour/models/Exceptions.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:eleventh_hour/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserController {
  UserController._();

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final Firestore _fireStore = Firestore.instance;

  static final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://th-hour-de18e.appspot.com');

  static Future<String> uploadFile(String userId, File image) async {
    try {
      StorageUploadTask uploadTask =
          _storage.ref().child('Profile Pictures/$userId.png').putFile(image);
      await uploadTask.onComplete;
      String fileURL = await _storage
          .ref()
          .child('Profile Pictures/$userId.png')
          .getDownloadURL();
      return fileURL;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<String> updateProfilePicture(
      {String userId, String oldImageURL, File newImage}) async {
    try {
      if (oldImageURL != kDefaultProfilePicUrl) {
        StorageReference photoRef =
            await _storage.getReferenceFromUrl(oldImageURL);
        await photoRef.delete();
      }

      String newFileURL = await uploadFile(userId, newImage);
      await _fireStore.collection("users").document(userId).updateData({
        'profilePicURL': newFileURL,
      });

      return newFileURL;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<String> removeProfilePicture(
      {String userId, String oldImageURL}) async {
    try {
      if (oldImageURL != kDefaultProfilePicUrl) {
        StorageReference photoRef =
            await _storage.getReferenceFromUrl(oldImageURL);
        await photoRef.delete();

        await _fireStore.collection("users").document(userId).updateData({
          'profilePicURL': kDefaultProfilePicUrl,
        });
      }
      return kDefaultProfilePicUrl;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<void> addToWishlist({String userId, String courseId}) async {
    await _fireStore.collection("users").document(userId).updateData({
      'wishlist': FieldValue.arrayUnion([courseId]),
    });
  }

  static Future<void> addToRecentCourses(
      {String userId, String courseId}) async {
    await _fireStore.collection("users").document(userId).updateData({
      'recentCoursesIds': FieldValue.arrayUnion([courseId]),
    });
  }

  static Future<void> handlePaymentSuccess(
      {String userId, List<String> courseIds}) async {
    await _fireStore.collection("users").document(userId).updateData(
        {'myCourses': FieldValue.arrayUnion(courseIds), 'cart': []});

    for (String courseId in courseIds) {
      await _fireStore.collection("courses").document(courseId).updateData({
        'enrolledUsers': FieldValue.arrayUnion([userId]),
      });
    }
  }

  static Future<void> addToCart({String userId, String courseId}) async {
    await _fireStore.collection("users").document(userId).updateData({
      'cart': FieldValue.arrayUnion([courseId]),
    });
  }

  static Future<void> updateCollege({String userId, String collegeId}) async {
    await _fireStore.collection("users").document(userId).updateData({
      'collegeId': collegeId,
    });
  }

  static Future<void> removeFromWishlist(
      {String userId, String courseId}) async {
    await _fireStore.collection("users").document(userId).updateData({
      'wishlist': FieldValue.arrayRemove([courseId]),
    });
  }

  static Future<void> removeFromCart({String userId, String courseId}) async {
    await _fireStore.collection("users").document(userId).updateData({
      'cart': FieldValue.arrayRemove([courseId]),
    });
  }

  static Future<User> getUser(String userId) async {
    DocumentSnapshot snapshot =
        await _fireStore.collection("users").document(userId).get();
    final User user = User.fromDocumentSnapshot(snapshot);
    return user;
  }

  static Future<void> changeCurrentUserPassword(
      {String oldPassword, String newPassword}) async {
    final FirebaseUser user = await getCurrentUser();

    AuthCredential credential = EmailAuthProvider.getCredential(
      email: user.email,
      password: oldPassword,
    );
    await user.reauthenticateWithCredential(credential);

    await user.updatePassword(newPassword);
    return true;
  }

  static Future<void> changeCurrentUserEmail(
      {String oldPassword, String newEmail}) async {
    final FirebaseUser user = await getCurrentUser();

    AuthCredential credential = EmailAuthProvider.getCredential(
      email: user.email,
      password: oldPassword,
    );
    await user.reauthenticateWithCredential(credential);

    await user.updateEmail(newEmail);
    await user.sendEmailVerification();
    return true;
  }

  static Future<void> updateNameAndPhone(
      {String userId, String name, String phone}) async {
    await _fireStore.collection("users").document(userId).updateData({
      'name': name,
      'phone': phone,
    });
    return true;
  }

  static Future<FirebaseUser> getCurrentUser() async {
    try {
      final FirebaseUser currentUser = await _auth.currentUser();
      if (currentUser != null && currentUser.isEmailVerified)
        return currentUser;
      else
        return null;
    } catch (e) {
      print("ERROR WHILE GETTING CURRENT USER : $e");
      return null;
    }
  }

  static Future<bool> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print("ERROR WHILE SENDING PASSWORD RESET EMAIL : $e");
      throw ForgotPasswordException(e.message);
    }
  }

  static Future<bool> resendEmailVerificationLink(
      String email, String password) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        await user.user.sendEmailVerification();
        return true;
      } else
        return false;
    } catch (e) {
      print("ERROR WHILE RE SENDING EMAIL VERIFICATION LINK : $e");
      return false;
    }
  }

  static Future<String> registerUser(
      {String name,
      String profilePicURL,
      String collegeId,
      String phone,
      String email,
      String password}) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await user.user.sendEmailVerification();

      if (user != null) {
        _fireStore.collection("users").document(user.user.uid).setData({
          "name": name,
          "phone": phone,
          "collegeId": collegeId,
          "profilePicURL": profilePicURL,
          "email": email,
          "myCourses": [],
          "cart": [],
          "recentCoursesIds": [],
          "myUploadedCourses": [],
          "wishlist": [],
          "transactionIds": [],
        });
        return user.user.uid;
      } else
        return null;
    } catch (e) {
      print("EXCEPTION WHILE REGISTERING NEW USER : $e");
      throw RegistrationException(e.message);
    }
  }

  static Future<String> loginUser({String email, String password}) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        if (user.user.isEmailVerified)
          return user.user.uid;
        else
          throw LoginException("EMAIL_NOT_VERIFIED");
      } else
        return null;
    } catch (e) {
      print("EXCEPTION WHILE LOGGING IN USER : $e");
      throw LoginException(e.message);
    }
  }

  static Future<bool> logoutUser() async {
    try {
      _auth.signOut();
      return true;
    } catch (e) {
      print("EXCEPTION WHILE LOGGING OUT USER : $e");
      return false;
    }
  }

  static Future<bool> updatePersonalDetails(
      {String name,
      String updatedProfileUrl,
      String uid,
      String collegeId,
      String phone,
      String email}) async {
    try {
      await _fireStore.collection('users').document(uid).updateData({
        'name': name,
        'profileURL': updatedProfileUrl,
        'collegeId': collegeId,
        'phone': phone,
        'email': email
      });
      return true;
    } catch (e) {
      print("caught error: $e");
      return false;
    }
  }
}
