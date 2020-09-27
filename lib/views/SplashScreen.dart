import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eleventh_hour/components/HomeBoilerPlate.dart';
import 'package:eleventh_hour/components/LoadingScreen.dart';
import 'package:eleventh_hour/controllers/CourseController.dart';
import 'package:eleventh_hour/models/College.dart';
import 'package:eleventh_hour/models/DeviceDimension.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:eleventh_hour/views/IntroScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  static const id = '/';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    String _userId = (prefs.getString('userId') ?? null);

    if (_seen) {
      if (_userId != null) {
        await getState();
        Navigator.popAndPushNamed(context, HomeBoilerPlate.id);
      } else {
        Navigator.popAndPushNamed(context, LoginScreen.id);
      }
    } else {
      await prefs.setBool('seen', true);
      Navigator.popAndPushNamed(context, IntroScreen.id);
    }
  }

  Future getState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _userId = (prefs.getString('userId') ?? null);

    if (_userId != null) {
      try {
        final userSnapshot = await Firestore.instance
            .collection("users")
            .document(_userId)
            .get();
        final collegeSnapshot = await Firestore.instance
            .collection("colleges")
            .document(userSnapshot['collegeId'])
            .get();
        setState(() {
          device = DeviceDimension(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width);
          user = User.fromDocumentSnapshot(userSnapshot);
          college = College.fromDocumentSnapshot(collegeSnapshot);
        });
        Provider.of<DeviceDimension>(context, listen: false)
            .updateDeviceInProvider(device: device);
        Provider.of<User>(context, listen: false).updateUserInProvider(user);
        Provider.of<College>(context, listen: false)
            .updateCollegeInProvider(college);
        await Provider.of<CourseController>(context, listen: false)
            .getCourses();
      } catch (err) {
        print(err);
      }
    }
  }

  User user = User(
      profilePicURL: "",
      phone: "",
      email: "",
      name: "",
      userId: "",
      collegeId: "");
  College college = College(name: "", subjectWithCourses: {}, cid: "");
  DeviceDimension device = DeviceDimension(width: 0.0, height: 0.0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkFirstSeen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingScreen(),
    );
  }
}
