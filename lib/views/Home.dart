import 'package:carousel_slider/carousel_slider.dart';
import 'package:eleventh_hour/components/CourseCard.dart';
import 'package:eleventh_hour/controllers/CourseController.dart';
import 'package:eleventh_hour/models/College.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:eleventh_hour/views/SubjectDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static const id = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {
  Future future;

  List<GestureDetector> _getChips() {
    List<GestureDetector> chips = [];

    final College college = Provider.of<College>(context);

    for (String subject in college.subjectWithCourses.keys) {
      chips.add(
        GestureDetector(
          onTap: () {
            print(college.subjectWithCourses[subject]);
            Navigator.pushNamed(context, SubjectDetails.id, arguments: subject);
          },
          child: Chip(
            padding: EdgeInsets.all(10),
            backgroundColor: Theme.of(context).accentColor,
            label: Text(
              subject,
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: Colors.black),
            ),
          ),
        ),
      );
    }

    return chips;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    future = Firestore.instance.collection("courses").getDocuments();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    try {
      return Scaffold(
        body: Consumer3<User, College, CourseController>(
          builder: (context, user, college, courses, child) {
            return ListView(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              children: [
                Text(
                  "${college.name}'s Subjects",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(
                  height: 10,
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20,
                  children: _getChips(),
                ),
                Text(
                  "  Trending",
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(
                  height: 20,
                ),
                CarouselSlider(
                    items: courses
                        .getTrendingCourses()
                        .map((course) => CourseCard(course: course, user: user))
                        .toList(),
                    options: CarouselOptions(
                      height: 345,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    )),
                SizedBox(height: 10),
                Text(
                  "  Continue Watching",
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(
                  height: 20,
                ),
                CarouselSlider(
                    items: courses
                        .getTrendingCourses()
                        .map((course) => CourseCard(course: course, user: user))
                        .toList(),
                    options: CarouselOptions(
                      height: 340,
                      scrollPhysics: BouncingScrollPhysics(),
                      viewportFraction: 0.9,
                      initialPage: 0,
                      enableInfiniteScroll: false,
                      reverse: false,
                      autoPlay: false,
                      enlargeCenterPage: false,
                      scrollDirection: Axis.horizontal,
                    )),
              ],
            );
          },
        ),
      );
    } catch (err) {
      return Text(err.toString());
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
