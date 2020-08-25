import 'package:eleventh_hour/views/Home.dart';
import 'package:eleventh_hour/views/IntroScreen.dart';
import 'package:eleventh_hour/views/LoadingScreen.dart';
import 'package:eleventh_hour/views/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static const id = '/';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future checkFirstSeen() async {
    await Future.delayed(Duration(seconds: 3));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    String _userId = (prefs.getString('userId') ?? null);

    if (_seen) {
      if (_userId != null) {
        Navigator.popAndPushNamed(context, Home.id);
      } else {
        Navigator.popAndPushNamed(context, LoginScreen.id);
      }
    } else {
      await prefs.setBool('seen', true);
      Navigator.popAndPushNamed(context, IntroScreen.id);
    }
  }

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
