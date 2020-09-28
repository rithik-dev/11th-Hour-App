import 'package:eleventh_hour/components/CustomVideoPlayer.dart';
import 'package:eleventh_hour/components/NeumoCard.dart';
import 'package:eleventh_hour/models/Course.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:eleventh_hour/utilities/UiIcons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import 'ResourcesPage.dart';

class LecturesPage extends StatefulWidget {
  final Course course;

  LecturesPage({this.course});

  static const id = '/lectures_page';

  @override
  _LecturesPageState createState() => _LecturesPageState();
}

class _LecturesPageState extends State<LecturesPage> {
  int videoIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: NeumorphicFloatingActionButton(
          style: NeumorphicTheme.currentTheme(context).buttonStyle.copyWith(
                color: NeumorphicTheme.currentTheme(context).accentColor,
              ),
          onPressed: () {
            Navigator.pushNamed(context, ResourcesPage.id,
                arguments: widget.course);
          },
          tooltip: "Go to Resources",
          child: Icon(
            UiIcons.folder,
            color: NeumorphicTheme.currentTheme(context).baseColor,
          ),
        ),
        body: Consumer<User>(
          builder: (context, user, child) {
            return ListView(
              physics: BouncingScrollPhysics(),
              children: [
                CustomVideoPlayer(
                  courseId: widget.course.id,
                  lectureUrl: widget.course.lectures[videoIndex]['lectureUrl'],
                ),
                NeumorphicCard(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.play_circle_outline,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          "${widget.course.lectures[videoIndex]['name']}",
                          style: NeumorphicTheme.currentTheme(context)
                              .textTheme
                              .headline3
                              .copyWith(color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: widget.course.lectures.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color:
                                NeumorphicTheme.currentTheme(context).baseColor,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  offset: Offset(1, 1),
                                  blurRadius: 10)
                            ]),
                        child: ListTile(
                          title: Text(
                            "${widget.course.lectures[index]['name']}",
                            style: NeumorphicTheme.currentTheme(context)
                                .textTheme
                                .headline3,
                          ),
                          onTap: () {
                            setState(() {
                              videoIndex = index;
                            });
                          },
                        ),
                      );
                    }),
              ],
            );
          },
        ),
      ),
    );
  }
}
