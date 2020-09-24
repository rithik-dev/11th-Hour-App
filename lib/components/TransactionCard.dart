import 'package:cloud_firestore/cloud_firestore.dart' as fire;
import 'package:eleventh_hour/components/NeumoCard.dart';
import 'package:eleventh_hour/components/SmallCourseCard.dart';
import 'package:eleventh_hour/controllers/CourseController.dart';
import 'package:eleventh_hour/models/Course.dart';
import 'package:eleventh_hour/models/DeviceDimension.dart';
import 'package:eleventh_hour/models/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  TransactionCard({this.transaction});

  List<Course> courses;

  @override
  Widget build(BuildContext context) {
    courses = Provider.of<CourseController>(context)
        .getCoursesByIds(transaction.courseIds.cast<String>());
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: Provider.of<DeviceDimension>(context).height * 0.5,
              child: Column(
                children: [
                  Text(
                    "\nCourses\n",
                    style: NeumorphicTheme.currentTheme(context)
                        .textTheme
                        .headline2,
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return SmallCourseCard(
                          course: courses[index],
                        );
                      },
                      itemCount: courses.length,
                    ),
                  ),
                  RaisedButton.icon(
                    highlightColor:
                        NeumorphicTheme.currentTheme(context).baseColor,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                    elevation: 0,
                    color: NeumorphicTheme.currentTheme(context).baseColor,
                    onPressed: () async {
                      if (await canLaunch(
                          "mailto:company.eleventhhour@gmail.com?subject=Help with transaction&body=\n\nTransaction ID : ${transaction.id}")) {
                        await launch(
                            "mailto:company.eleventhhour@gmail.com?subject=Help with transaction&body=\n\nTransaction ID : ${transaction.id}");
                      } else {
                        throw 'Could not launch';
                      }
                    },
                    icon: Icon(Icons.contact_mail),
                    label: Text(
                      "Need Help ?",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
      child: NeumorphicCard(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Rs. ${this.transaction.amount}/-",
                  style:
                      NeumorphicTheme.currentTheme(context).textTheme.headline2,
                ),
                Text(
                  getDisplayDate(this.transaction.date),
                  style:
                      NeumorphicTheme.currentTheme(context).textTheme.headline3,
                ),
                Text("ID: ${this.transaction.id}"),
              ],
            ),
            Icon(
              this.transaction.status == "Success" ? Icons.check : Icons.clear,
              color: this.transaction.status == "Success"
                  ? Colors.green
                  : Colors.red,
              size: 40,
            )
          ],
        ),
      ),
    );
  }

  static String getDisplayDate(fire.Timestamp timestamp) {
    String displayDate;
    DateFormat formatter;

    formatter = DateFormat('d MMMM yyyy');
    displayDate = formatter.format(timestamp.toDate());

    return displayDate;
  }
}
