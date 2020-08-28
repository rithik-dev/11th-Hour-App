import 'package:eleventh_hour/components/HomeBoilerPlate.dart';
import 'package:eleventh_hour/views/Cart.dart';
import 'package:eleventh_hour/views/ConnectionLostScreen.dart';
import 'package:eleventh_hour/views/IntroScreen.dart';
import 'package:eleventh_hour/views/LoginScreen.dart';
import 'package:eleventh_hour/views/MyUploadedCoursesScreen.dart';
import 'package:eleventh_hour/views/ProfileScreen.dart';
import 'package:eleventh_hour/views/RegistrationScreen.dart';
import 'package:eleventh_hour/views/SplashScreen.dart';
import 'package:eleventh_hour/views/SubjectDetails.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
// Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    print(settings.name);
    switch (settings.name) {
      case SubjectDetails.id:
        return PageTransition(
            child: SubjectDetails(), type: PageTransitionType.downToUp);
      case HomeBoilerPlate.id:
        return PageTransition(
            child: HomeBoilerPlate(),
            type: PageTransitionType.leftToRightWithFade);
//      case WishlistScreen.id:
//        return PageTransition(
//            child: WishlistScreen(),
//            type: PageTransitionType.leftToRightWithFade);
//      case MyCoursesScreen.id:
//        return PageTransition(
//            child: MyCoursesScreen(),
//            type: PageTransitionType.leftToRightWithFade);
      case MyUploadedCoursesScreen.id:
        return PageTransition(
            child: MyUploadedCoursesScreen(),
            type: PageTransitionType.leftToRightWithFade);
      case ProfileScreen.id:
        return PageTransition(
            child: ProfileScreen(),
            type: PageTransitionType.leftToRightWithFade);
//      case Home.id:
//        return PageTransition(
//            child: Home(), type: PageTransitionType.leftToRightWithFade);
      case IntroScreen.id:
        return PageTransition(
            child: IntroScreen(), type: PageTransitionType.leftToRightWithFade);
      case CartScreen.id:
        return PageTransition(
            child: CartScreen(), type: PageTransitionType.downToUp);
      case LoginScreen.id:
        return PageTransition(
            child: LoginScreen(), type: PageTransitionType.rightToLeftWithFade);
      case RegistrationScreen.id:
        return PageTransition(
            child: RegistrationScreen(),
            type: PageTransitionType.rightToLeftWithFade);
      case SplashScreen.id:
        return PageTransition(
            child: SplashScreen(), type: PageTransitionType.rotate);
      case ConnectionLost.id:
        return PageTransition(
            child: ConnectionLost(),
            type: PageTransitionType.leftToRightWithFade);
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
