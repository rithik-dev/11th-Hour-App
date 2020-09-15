import 'package:carousel_slider/carousel_slider.dart';
import 'package:eleventh_hour/components/CourseCard.dart';
import 'package:eleventh_hour/controllers/CourseController.dart';
import 'package:eleventh_hour/models/College.dart';
import 'package:eleventh_hour/models/DeviceDimension.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:eleventh_hour/views/SubjectDetails.dart';
import 'package:eleventh_hour/views/ViewAll.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static const id = '/home';
  final Function(int index) callback;

  Home({this.callback});

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
                NeuCard(
                  decoration: NeumorphicDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  bevel: 5,
                  margin: EdgeInsets.fromLTRB(10, 20, 10, 5),
                  curveType: CurveType.concave,
                  padding: EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Trending",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      RaisedButton.icon(
                          color: Theme.of(context).primaryColor,
                          shape: StadiumBorder(),
                          onPressed: () {
                            Navigator.pushNamed(context, ViewAll.id,
                                arguments: {
                                  'title': "Trending",
                                  'courses': courses.getTrendingCourses(),
                                });
                          },
                          icon: Icon(
                            FontAwesomeIcons.arrowRight,
                            size: 15,
                          ),
                          label: Text(
                            "View all",
                            style: Theme.of(context).textTheme.bodyText1,
                          ))
                    ],
                  ),
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
                // if no course in recent then check if course if "MyCourse" ,if not then show sized box else show my courses or if data in recent courses show recent courses
                user.recentCoursesIds.length == 0
                    ? user.myCourses.length >= 1
                        ? Text(
                            "Start Watching",
                            style: Theme.of(context).textTheme.headline1,
                            textAlign: TextAlign.center,
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    Provider.of<DeviceDimension>(context)
                                            .width *
                                        0.15),
                            child: RaisedButton.icon(
                              padding: EdgeInsets.all(10),
                              elevation: 15,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              onPressed: () {
                                widget.callback(3);
                              },
                              color: Theme.of(context).primaryColor,
                              icon: Icon(
                                Icons.search,
                                size: 35,
                              ),
                              label: Text(
                                "Browse Courses",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Resume",
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          RaisedButton.icon(
                              color: Theme.of(context).primaryColor,
                              shape: StadiumBorder(),
                              onPressed: () {
                                Navigator.pushNamed(context, ViewAll.id,
                                    arguments: {
                                      'courses': courses.getCoursesByIds(
                                          user.recentCoursesIds.cast<String>()),
                                      'title': 'Continue Watching'
                                    });
                              },
                              icon: Icon(
                                FontAwesomeIcons.arrowRight,
                                size: 15,
                              ),
                              label: Text(
                                "View all",
                                style: Theme.of(context).textTheme.bodyText1,
                              ))
                        ],
                      ),

                user.recentCoursesIds.length == 0
                    ? user.myCourses.length >= 1
                        ? SizedBox(
                            height: 20,
                          )
                        : SizedBox.shrink()
                    : SizedBox(
                        height: 20,
                      ),

                user.recentCoursesIds.length == 0
                    ? user.myCourses.length >= 1
                        ? CarouselSlider(
                            items: courses
                                .getCoursesByIds(user.myCourses.reversed
                                    .cast<String>()
                                    .toList())
                                .map((course) =>
                                    CourseCard(course: course, user: user))
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
                            ))
                        : SizedBox.shrink()
                    : CarouselSlider(
                        items: courses
                            .getCoursesByIds(user.recentCoursesIds.reversed
                                .cast<String>()
                                .toList())
                            .map((course) =>
                                CourseCard(course: course, user: user))
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
                        ))
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
