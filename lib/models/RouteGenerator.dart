import 'package:eleventh_hour/views/ConnectionLostScreen.dart';
import 'package:eleventh_hour/views/Home.dart';
import 'package:eleventh_hour/views/IntroScreen.dart';
import 'package:eleventh_hour/views/LoginScreen.dart';
import 'package:eleventh_hour/views/MyCoursesScreen.dart';
import 'package:eleventh_hour/views/MyUploadedCoursesScreen.dart';
import 'package:eleventh_hour/views/ProfileScreen.dart';
import 'package:eleventh_hour/views/RegistrationScreen.dart';
import 'package:eleventh_hour/views/SplashScreen.dart';
import 'package:eleventh_hour/views/WishlistScreen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
// Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case WishlistScreen.id:
        return MaterialPageRoute(builder: (_) => WishlistScreen());
      case MyCoursesScreen.id:
        return MaterialPageRoute(builder: (_) => MyCoursesScreen());
      case MyUploadedCoursesScreen.id:
        return MaterialPageRoute(builder: (_) => MyUploadedCoursesScreen());
      case ProfileScreen.id:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case Home.id:
        return MaterialPageRoute(builder: (_) => Home());
      case IntroScreen.id:
        return MaterialPageRoute(builder: (_) => IntroScreen());
      case LoginScreen.id:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case RegistrationScreen.id:
        return MaterialPageRoute(builder: (_) => RegistrationScreen());
      case SplashScreen.id:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case ConnectionLost.id:
        print("connect lost");
        return MaterialPageRoute(builder: (_) => ConnectionLost());
// Validation of correct data type
//        if (args is String) {
//          return MaterialPageRoute(
//            builder: (_) => SecondPage(
//              data: args,
//            ),
//          );
//        }
// If args is not of the correct type, return an error page.
//        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
