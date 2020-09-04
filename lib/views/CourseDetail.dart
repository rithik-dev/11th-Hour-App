import 'package:eleventh_hour/components/CustomVideoPlayer.dart';
import 'package:eleventh_hour/models/Course.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseDetails extends StatefulWidget {
  final Course course;

  CourseDetails({this.course});

  static const id = '/details';

  @override
  _CourseDetailsState createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  int videoIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<User>(
          builder: (context, user, child) {
            return Column(
              children: [
                CustomVideoPlayer(
                  lectureUrl: widget.course.lectures[videoIndex]['lectureUrl'],
                ),
                Container(
                  height: 80,
                  color: Theme.of(context).primaryColor,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: ListTile(
                    leading: Image(
                      image: NetworkImage(widget.course.courseThumbnail),
                    ),
                    title: Text(
                      widget.course.lectures[videoIndex]['name'],
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: widget.course.lectures.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 2.5),
                          color: Colors.grey[900],
                          child: ListTile(
                            title: Text(
                              widget.course.lectures[index]['name'],
                              style: Theme.of(context).textTheme.headline3,
                            ),
                            onTap: () {
                              setState(() {
                                videoIndex = index;
                              });
                            },
                          ),
                        );
                      }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
