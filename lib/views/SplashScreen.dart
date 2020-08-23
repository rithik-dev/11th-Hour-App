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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);
    String _userId = (prefs.getString('userId') ?? null);

    if (_seen) {
      if (_userId != null) {
        Navigator.pushReplacementNamed(context, Home.id);
      } else {
        Navigator.pushReplacementNamed(context, LoginScreen.id);
      }
    } else {
      await prefs.setBool('seen', true);
      Navigator.pushReplacementNamed(context, IntroScreen.id);
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
