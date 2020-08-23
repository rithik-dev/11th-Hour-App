import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:eleventh_hour/models/RouteGenerator.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:eleventh_hour/utilities/constants.dart';
import 'package:eleventh_hour/views/ConnectionLostScreen.dart';
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
    getCurrentUser();
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

  User user = User();

  void getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _userId = (prefs.getString('userId') ?? null);

    if (_userId != null) {
      final snapshot =
          await Firestore.instance.collection("users").document(_userId).get();

      setState(() {
        user = User.fromDocumentSnapshot(snapshot);
      });
      print(user.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<User>.value(value: user),
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
