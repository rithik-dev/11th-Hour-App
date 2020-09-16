import 'package:eleventh_hour/components/CustomVideoPlayer.dart';
import 'package:eleventh_hour/models/Course.dart';
import 'package:eleventh_hour/models/DeviceDimension.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

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
        body: Consumer<User>(
          builder: (context, user, child) {
            return ListView(
              children: [
                CustomVideoPlayer(
                  courseId: widget.course.id,
                  lectureUrl: widget.course.lectures[videoIndex]['lectureUrl'],
                ),
                Container(
                  height: Provider.of<DeviceDimension>(context).height * 0.1,
                  color: NeumorphicTheme.currentTheme(context).baseColor,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: ListTile(
                    leading: Image(
                      image: NetworkImage(widget.course.courseThumbnail),
                    ),
                    title: Text(
                      widget.course.lectures[videoIndex]['name'],
                      style: NeumorphicTheme.currentTheme(context)
                          .textTheme
                          .headline1,
                    ),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.course.lectures.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
                        color: Colors.grey[900],
                        child: ListTile(
                          title: Text(
                            widget.course.lectures[index]['name'],
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
