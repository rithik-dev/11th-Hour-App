import 'package:eleventh_hour/components/SmallCourseCard.dart';
import 'package:eleventh_hour/models/Course.dart';
import 'package:flutter/material.dart';

class ViewAll extends StatelessWidget {
  static const id = '/view_all';

//  final List<Course> courses;
//  final String title;
  final Map<String, dynamic> data;

  ViewAll({@required this.data});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(this.data['title']),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 20),
          children: (this.data['courses'] as List<Course>)
              .map((e) => SmallCourseCard(course: e))
              .toList(),
        ),
      ),
    );
  }
}
