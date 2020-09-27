import 'package:eleventh_hour/components/HomeBoilerPlate.dart';
import 'package:eleventh_hour/models/Course.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:eleventh_hour/utilities/UiIcons.dart';
import 'package:eleventh_hour/views/PdfPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class ResourcesPage extends StatefulWidget {
  static const id = '/resources';
  final Course course;

  ResourcesPage({this.course});

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
      body: Consumer<User>(
        builder: (context, user, child) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: widget.course.resources.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: NeumorphicTheme.currentTheme(context).baseColor,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: Offset(1, 1),
                            blurRadius: 10)
                      ]),
                  child: ListTile(
                    title: Text(
                      "${widget.course.resources[index]['name']}",
                      style: NeumorphicTheme.currentTheme(context)
                          .textTheme
                          .headline3,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, PdfPage.id,
                          arguments: widget.course.resources[index]
                              ['resourceUrl']);
                    },
                  ),
                );
              });
        },
      ),
    );
  }
}
