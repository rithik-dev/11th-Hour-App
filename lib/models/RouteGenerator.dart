import 'package:eleventh_hour/components/HomeBoilerPlate.dart';
import 'package:eleventh_hour/views/AboutUs.dart';
import 'package:eleventh_hour/views/Cart.dart';
import 'package:eleventh_hour/views/ConnectionLostScreen.dart';
import 'package:eleventh_hour/views/CourseDetails.dart';
import 'package:eleventh_hour/views/InfoAndSupport.dart';
import 'package:eleventh_hour/views/IntroScreen.dart';
import 'package:eleventh_hour/views/LecturesPage.dart';
import 'package:eleventh_hour/views/LoginScreen.dart';
import 'package:eleventh_hour/views/MyTransactionsHistory.dart';
import 'package:eleventh_hour/views/MyUploadedCoursesScreen.dart';
import 'package:eleventh_hour/views/NoCollegeScreen.dart';
import 'package:eleventh_hour/views/PdfPage.dart';
import 'package:eleventh_hour/views/ProfileScreen.dart';
import 'package:eleventh_hour/views/RefundPolicy.dart';
import 'package:eleventh_hour/views/RegistrationScreen.dart';
import 'package:eleventh_hour/views/ResourcesPage.dart';
import 'package:eleventh_hour/views/SearchPage.dart';
import 'package:eleventh_hour/views/SplashScreen.dart';
import 'package:eleventh_hour/views/SubjectDetails.dart';
import 'package:eleventh_hour/views/Terms&Condn.dart';
import 'package:eleventh_hour/views/ViewAll.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
// Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case PdfPage.id:
        return PageTransition(
          child: PdfPage(
            resourceUrl: args,
          ),
          type: PageTransitionType.downToUp,
        );
      case ResourcesPage.id:
        return PageTransition(
          child: ResourcesPage(
            course: args,
          ),
          type: PageTransitionType.downToUp,
        );
      case SubjectDetails.id:
        return PageTransition(
          child: SubjectDetails(
            subject: args,
          ),
          type: PageTransitionType.downToUp,
        );
      case ViewAll.id:
        return PageTransition(
          child: ViewAll(
            data: args,
          ),
          type: PageTransitionType.leftToRightWithFade,
        );
      case NoCollegeScreen.id:
        return PageTransition(
          child: NoCollegeScreen(),
          type: PageTransitionType.leftToRightWithFade,
        );
      case CourseDetails.id:
        return PageTransition(
          child: CourseDetails(course: args),
          type: PageTransitionType.leftToRightWithFade,
        );
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
      case RefundPolicies.id:
        return PageTransition(
            child: RefundPolicies(),
            type: PageTransitionType.leftToRightWithFade);
      case SearchPage.id:
        return PageTransition(
            child: SearchPage(), type: PageTransitionType.leftToRightWithFade);
      case MyUploadedCoursesScreen.id:
        return PageTransition(
            child: MyUploadedCoursesScreen(),
            type: PageTransitionType.leftToRightWithFade);
      case MyTransactionsHistory.id:
        return PageTransition(
            child: MyTransactionsHistory(),
            type: PageTransitionType.leftToRightWithFade);
      case InfoAndSupport.id:
        return PageTransition(
            child: InfoAndSupport(),
            type: PageTransitionType.leftToRightWithFade);
      case LecturesPage.id:
        return PageTransition(
            child: LecturesPage(
              course: args,
            ),
            type: PageTransitionType.leftToRightWithFade);
      case AboutUs.id:
        return PageTransition(
            child: AboutUs(), type: PageTransitionType.leftToRightWithFade);
      case TermsAndCondition.id:
        return PageTransition(
            child: TermsAndCondition(),
            type: PageTransitionType.leftToRightWithFade);
      case ProfileScreen.id:
        return PageTransition(
            child: ProfileScreen(),
            type: PageTransitionType.leftToRightWithFade);
      case IntroScreen.id:
        return PageTransition(
            child: IntroScreen(), type: PageTransitionType.leftToRightWithFade);
      case CartScreen.id:
        return PageTransition(
            child: CartScreen(), type: PageTransitionType.downToUp);
      case LoginScreen.id:
        return PageTransition(
            child: LoginScreen(
              email: args != null ? (args as List)[0] : "",
              password: args != null ? (args as List)[1] : "",
            ),
            type: PageTransitionType.rightToLeftWithFade);
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
