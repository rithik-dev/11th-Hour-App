import 'package:eleventh_hour/components/NeumoCard.dart';
import 'package:eleventh_hour/utilities/constants.dart';
import 'package:eleventh_hour/views/RegistrationScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

class IntroScreen extends StatelessWidget {
  static const id = '/intro';
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.popAndPushNamed(context, RegistrationScreen.id);
  }

  Widget _buildImage(String assetName) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
      child:
          Lottie.asset('assets/lottie/$assetName.json', width: double.infinity),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: IntroductionScreen(
          key: introKey,
          pages: [
            PageViewModel(
              title: "Exams? Worry not!!",
              body:
                  "\nGet access to college-specific curriculum taught by your seniors or that topper friend you have!!",
              image: _buildImage('exam'),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Freelancing using academics?",
              body:
                  "Ofcourse, You can teach your friends by uploading courses.\n\n Using our website you can upload courses relevant to your college!!",
              image: _buildImage('money'),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "\nSave yourself @11Hour",
              body: "\n\nStart enrolling in our courses!!",
              image: _buildImage('clock'),
              decoration: pageDecoration,
            ),
          ],
          onDone: () => _onIntroEnd(context),
          onSkip: () => _onIntroEnd(context),
          // You can override onSkip callback
          showSkipButton: true,
          skipFlex: 0,

          nextFlex: 0,
          skip: NeumorphicCard(
            child: Text(
              'Skip',
              style: NeumorphicTheme.currentTheme(context).textTheme.headline4,
            ),
            padding: EdgeInsets.all(10),
          ),
          next: NeumorphicCard(
            padding: EdgeInsets.all(7),
            child: Icon(
              Icons.arrow_forward,
              size: 28,
            ),
          ),
          done: NeumorphicCard(
            child: Text(
              'Done',
              style: NeumorphicTheme.currentTheme(context).textTheme.headline4,
            ),
            padding: EdgeInsets.all(10),
          ),
          dotsDecorator: DotsDecorator(
            activeColor: NeumorphicTheme.currentTheme(context).accentColor,
            size: Size(10.0, 10.0),
            color: Colors.black,
            activeSize: Size(22.0, 10.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
        ),
      ),
    );
  }
}
