import 'package:eleventh_hour/components/HomeBoilerPlate.dart';
import 'package:eleventh_hour/utilities/UiIcons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ResourcesPage extends StatefulWidget {
  static const id = '/resources';
  @override
  _ResourcesPageState createState() => _ResourcesPageState();
}

class _ResourcesPageState extends State<ResourcesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: Text("Resources"),
        actions: [
          NeumorphicButton(
            onPressed: () {
              Navigator.pushNamed(context, HomeBoilerPlate.id);
            },
            child: Icon(UiIcons.home),
          )
        ],
        centerTitle: true,
      ),
    );
  }
}
