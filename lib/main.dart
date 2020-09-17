import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:eleventh_hour/controllers/CourseController.dart';
import 'package:eleventh_hour/models/College.dart';
import 'package:eleventh_hour/models/RouteGenerator.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:eleventh_hour/utilities/constants.dart';
import 'package:eleventh_hour/views/ConnectionLostScreen.dart';
import 'package:eleventh_hour/views/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import 'models/DeviceDimension.dart';

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
  DeviceDimension device = DeviceDimension(width: 0.0, height: 0.0);
  College college = College(name: "", subjectWithCourses: {}, cid: "");
  CourseController courseProvider = CourseController(courses: []);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey[800],
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DeviceDimension>.value(value: device),
        ChangeNotifierProvider<College>.value(value: college),
        ChangeNotifierProvider<User>.value(value: user),
        ChangeNotifierProvider<CourseController>.value(value: courseProvider),
      ],
      child: NeumorphicApp(
        navigatorKey: nav,
        theme: kDefaultTheme,
        darkTheme: kDefaultTheme,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: SplashScreen.id,
      ),
    );
  }
}
