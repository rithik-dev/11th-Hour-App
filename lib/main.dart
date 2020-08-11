import 'package:eleventh_hour/screens/SplashScreen.dart';
import 'package:eleventh_hour/utilities/constants.dart';
import 'package:flutter/material.dart';

import 'models/routeGenerator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: kDefaultTheme,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: SplashScreen.id,
    );
  }
}
