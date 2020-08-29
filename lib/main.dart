import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:eleventh_hour/controllers/CourseController.dart';
import 'package:eleventh_hour/models/College.dart';
import 'package:eleventh_hour/models/Course.dart';
import 'package:eleventh_hour/models/RouteGenerator.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:eleventh_hour/utilities/constants.dart';
import 'package:eleventh_hour/views/ConnectionLostScreen.dart';
import 'package:eleventh_hour/views/LoginScreen.dart';
import 'package:eleventh_hour/views/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

final GlobalKey<NavigatorState> nav = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription connectivitySubscription;

  ConnectivityResult _previousResult;

  @override
  void dispose() {
    super.dispose();
    connectivitySubscription.cancel();
  }

  @override
  void initState() {
    super.initState();
    getState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        nav.currentState.pushNamed(ConnectionLost.id);
      } else if (_previousResult == ConnectivityResult.none) {
        nav.currentState.pushNamed(SplashScreen.id);
      }
      _previousResult = connectivityResult;
    });
  }

  User user = User(
      profilePicURL: "",
      phone: "",
      email: "",
      name: "",
      userId: "",
      collegeId: "");
  College college = College(name: "", subjectWithCourses: {}, cid: "");
  CourseController courseProvider = CourseController(courses: []);

  void getState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _userId = (prefs.getString('userId') ?? null);

    final coursesSnapshot =
        await Firestore.instance.collection("courses").getDocuments();

    List<Course> courses = [];
    for (DocumentSnapshot snapshot in coursesSnapshot.documents) {
      final Course course = Course.fromDocumentSnapshot(snapshot);
      courses.add(course);
    }

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
          user = User.fromDocumentSnapshot(userSnapshot);
          college = College.fromDocumentSnapshot(collegeSnapshot);
          courseProvider = CourseController(courses: courses);
        });

        print(user.toString());
      } catch (err) {
        print(err);
        Navigator.popAndPushNamed(context, LoginScreen.id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey[800],
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<College>.value(value: college),
        ChangeNotifierProvider<User>.value(value: user),
        ChangeNotifierProvider<CourseController>.value(value: courseProvider),
      ],
      child: MaterialApp(
        navigatorKey: nav,
        theme: kDefaultTheme,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: SplashScreen.id,
      ),
    );
  }
}
