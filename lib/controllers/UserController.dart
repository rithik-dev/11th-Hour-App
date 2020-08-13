import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eleventh_hour/models/Exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserController {
  UserController._();

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final Firestore _fireStore = Firestore.instance;

//  static Future<FirebaseUser> getCurrentUser() async {
//    try {
//      final FirebaseUser currentUser = await _auth.currentUser();
//      if (currentUser != null && currentUser.isEmailVerified)
//        return currentUser;
//      else
//        return null;
//    } catch (e) {
//      print("ERROR WHILE GETTING CURRENT USER : $e");
//      return null;
//    }
//  }

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

  static Future<bool> registerUser(
      {String email, String password, String name}) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await user.user.sendEmailVerification();

      if (user != null) {
        // creating document for new user
        _fireStore.collection("users").document(user.user.uid).setData({
//          "fullName": fullName,
        });
        return true;
      } else
        return false;
    } catch (e) {
      print("EXCEPTION WHILE REGISTERING NEW USER : $e");
      throw RegistrationException(e.message);
    }
  }

  static Future<bool> loginUser(String email, String password) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        if (user.user.isEmailVerified)
          return true;
        else
          throw LoginException("EMAIL_NOT_VERIFIED");
      } else
        return false;
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
      {name, updatedProfileUrl, uid, collegeId, phone,email}) async {
    try {
      await _fireStore.collection('users').document(uid).updateData({
        'name': name,
        'profileURL': updatedProfileUrl,
        'collegeId': collegeId,
        'phone': phone,
        'email':email
      });
      return true;
    } catch (e) {
      print("caught error: $e");
      return false;
    }
  }
}
