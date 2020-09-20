import 'package:eleventh_hour/controllers/CourseController.dart';
import 'package:eleventh_hour/models/Course.dart';
import 'package:eleventh_hour/models/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  final bool isShimmer;

  TransactionCard({this.transaction, this.isShimmer = false});

  List<Course> courses;

  @override
  Widget build(BuildContext context) {
    if (!isShimmer)
      courses = Provider.of<CourseController>(context)
          .getCoursesByIds(transaction.courseIds);
    return Container(
      height: 100,
      width: 300,
      color: Colors.white,
      child: Column(
        children: [
          Text(isShimmer ? "" : transaction.courseIds),
        ],
      ),
    );
  }
}
