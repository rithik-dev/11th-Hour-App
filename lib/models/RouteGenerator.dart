import 'package:eleventh_hour/views/LoginScreen.dart';
import 'package:eleventh_hour/views/RegistrationScreen.dart';
import 'package:eleventh_hour/views/SplashScreen.dart';
import 'package:eleventh_hour/views/ConnectionLostScreen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
// Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case LoginScreen.id:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case RegistrationScreen.id:
        return MaterialPageRoute(builder: (_) => RegistrationScreen());
      case SplashScreen.id:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case ConnectionLost.id:
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
