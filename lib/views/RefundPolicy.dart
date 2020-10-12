import 'package:eleventh_hour/components/HomeBoilerPlate.dart';
import 'package:eleventh_hour/utilities/UiIcons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:lottie/lottie.dart';

class RefundPolicies extends StatelessWidget {
  static const id = '/refund_policies';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: Text("Refund Policies"),
        actions: [
          NeumorphicButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeBoilerPlate.id, (route) => false);
            },
            child: Icon(UiIcons.home),
          )
        ],
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        physics: BouncingScrollPhysics(),
        children: [
          Text(
            "\nTo place a refund, return or exchange request for an order placed by clicking on the \"Ask for refund\" button on the course page. Your request will be considered valid if it is placed within 10 days of purchase.\n\nYour request will be reviewed and we will contact you within 2 working days.",
            style: NeumorphicTheme.currentTheme(context).textTheme.headline5,
          ),
          Lottie.asset('assets/lottie/refund.json'),
        ],
      ),
    );
  }
}
