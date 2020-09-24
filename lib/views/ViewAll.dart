import 'package:eleventh_hour/components/SmallCourseCard.dart';
import 'package:eleventh_hour/models/Course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ViewAll extends StatelessWidget {
  static const id = '/view_all';

  final Map<String, dynamic> data;

  ViewAll({@required this.data});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: NeumorphicAppBar(
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
