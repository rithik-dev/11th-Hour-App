import 'package:eleventh_hour/models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPref {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future updatePersonalDetails(
      {String name, String profileURL, String collegeId, String phone,String email}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('collegeId');
    await prefs.remove('phone');
    await prefs.remove('name');
    await prefs.remove('email');
    await prefs.remove('profileURL');
    /////////////////////////////////
    await prefs.setString('phoneNumber', phone);
    await prefs.setString('collegeId', collegeId);
    await prefs.setString('name', name);
    await prefs.setString('profileUrl', profileURL);
    await prefs.setString('email', email);
  }

  Future storeUserInSharedPreferences({
    String userId,
    String phone,
    String name,
    String email,
    String profileURL,
    String collegeId,
    List<String> myUploadedCourses,
    List<String> wishlist,
    List<String> myCourses,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('userId', userId);
    await prefs.setString('phoneNumber', phone);
    await prefs.setString('collegeId', collegeId);
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('profileUrl', profileURL);

    print('saved successfully');
  }

  //fetch the user details from shared preferences
  Future<User> getUserFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return User(
      collegeId: prefs.getString('collegeId'),
      profileURL: prefs.getString('profileURL'),
      phone: prefs.getString('phone'),
      name: prefs.getString('name'),
      userId: prefs.getString('userId'),
      email: prefs.getString('email'),
    );
  }

  Future logOutUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('userId');
      await prefs.remove('collegeId');
      await prefs.remove('phone');
      await prefs.remove('name');
      await prefs.remove('email');
      await prefs.remove('profileURL');
      await _auth.signOut();
    } catch (err) {
      print(err);
    }
  }
}
