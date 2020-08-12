import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:eleventh_hour/views/SplashScreen.dart';
import 'package:eleventh_hour/utilities/constants.dart';
import 'package:eleventh_hour/views/ConnectionLostScreen.dart';
import 'package:eleventh_hour/views/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:eleventh_hour/models/routeGenerator.dart';

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
        nav.currentState.push(
            MaterialPageRoute(builder: (BuildContext _) => ConnectionLost()));
      } else if (_previousResult == ConnectivityResult.none) {
        nav.currentState.push(
            MaterialPageRoute(builder: (BuildContext _) => SplashScreen()));
      }
      _previousResult = connectivityResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
      theme: kDefaultTheme,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: LoginScreen.id,
    );
  }
}
