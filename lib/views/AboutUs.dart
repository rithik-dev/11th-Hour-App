import 'package:eleventh_hour/components/HomeBoilerPlate.dart';
import 'package:eleventh_hour/utilities/UiIcons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AboutUs extends StatelessWidget {
  static const id = '/about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: Text("About Us"),
        centerTitle: true,
        actions: [
          NeumorphicButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeBoilerPlate.id, (route) => false);
            },
            child: Icon(UiIcons.home),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        physics: BouncingScrollPhysics(),
        children: [
          Text(
            "Our project binds together the rich flavors of peer teaching and freelancing into one platform. We will offer an application and a website that is secure with a clean and easy to use interface along with a simple user experience to upload and access various courses.\n\nVia this platform, every student will get access to college-specific content at ease of his mobile/laptop, it will also allow studious and dedicated students to upload their own course at a price that seems fair to them. These features will allow students across different colleges to focus on their studies instead of seeking job opportunities that do not provide personal or professional growth for little to no money.\n\nApart from freelancing opportunities, our platform will also help students a night before their examination by providing them concise courses that are to the point, along with practice problems or solved previous year papers related to the topic of course.\nHence at the 11th hour, our 11th hour is a student's way to go.",
            style: NeumorphicTheme.currentTheme(context).textTheme.headline5,
          )
        ],
      ),
    );
  }
}
