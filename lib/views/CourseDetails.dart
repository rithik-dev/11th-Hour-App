import 'package:eleventh_hour/components/CachedImage.dart';
import 'package:eleventh_hour/components/CustomVideoPlayer.dart';
import 'package:eleventh_hour/components/LoadingScreen.dart';
import 'package:eleventh_hour/components/NeumoCard.dart';
import 'package:eleventh_hour/components/ProfilePicture.dart';
import 'package:eleventh_hour/controllers/CourseController.dart';
import 'package:eleventh_hour/controllers/UserController.dart';
import 'package:eleventh_hour/models/Course.dart';
import 'package:eleventh_hour/models/DeviceDimension.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:eleventh_hour/utilities/UiIcons.dart';
import 'package:eleventh_hour/views/LecturesPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseDetails extends StatefulWidget {
  static const id = '/course_details';
  final Course course;

  CourseDetails({
    @required this.course,
  });

  @override
  _CourseDetailsState createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  bool isLoading = false;
  double newRating = 0;

  double calcRating(List ratings) {
    if (ratings == null) return 0;
    double _rating = 0;

    ratings.forEach((rating) {
      _rating += rating['userRating'];
    });
    _rating = _rating / ratings.length;
    return _rating;
  }

  User instructor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInstructor();
  }

  Future<void> getInstructor() async {
    instructor = await UserController.getUser(widget.course.instructorId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    bool isFavorite = user.wishlist.contains(widget.course.id);
    Iterable haveRated = widget.course?.ratings
        ?.where((element) => element['userId'] == user.userId);
    bool isMyCourse = user.myCourses.contains(widget.course.id);

    return Stack(
      children: [
        Scaffold(
          body: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                  height: Provider.of<DeviceDimension>(context).height * 0.28,
                  child: CustomVideoPlayer(
                    lectureUrl: widget.course.lectures[0]['lectureUrl'],
                    addToRecent: false,
                  )),
              Container(
                width: double.infinity,
                height: Provider.of<DeviceDimension>(context).height * 0.11,
                decoration: BoxDecoration(
                  color: NeumorphicTheme.currentTheme(context).baseColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CachedImage(
                      url: widget.course.courseThumbnail,
                      infinity: false,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        widget.course.title,
                        style: NeumorphicTheme.currentTheme(context)
                            .textTheme
                            .headline4,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(
                      widget.course.description,
                      style: NeumorphicTheme.currentTheme(context)
                          .textTheme
                          .headline5
                          .copyWith(fontSize: 18),
                    ),
                    isMyCourse
                        ? SizedBox.shrink()
                        : ExpansionTile(
                            initiallyExpanded: true,
                            childrenPadding: EdgeInsets.all(5),
                            title: Text("List Of Lectures"),
                            children: widget.course.lectures
                                .map((e) => ListTile(
                                      title: Text(e['name']),
                                    ))
                                .toList(),
                          ),
                  ],
                ),
              ),
              Stack(
                children: [
                  NeumorphicCard(
                    margin: EdgeInsets.all(35),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                    child: Column(
                      children: [
                        StarRating(
                          size: 35.0,
                          rating: widget.course.ratings == null ||
                                  widget.course.ratings.length == 0
                              ? 0
                              : calcRating(widget.course.ratings),
                          color: Colors.amber,
                          borderColor: Colors.grey,
                          starCount: 5,
                          onRatingChanged: (r) {},
                        ),
                        Text(
                          "Total Ratings: ${widget.course.ratings.length}",
                          style: NeumorphicTheme.currentTheme(context)
                              .textTheme
                              .subtitle1,
                        ),
                        widget.course.ratings != null
                            ? haveRated.length != 0
                                ? Text(
                                    "\nYour Rating: ${haveRated.first['userRating']} ⭐\n",
                                    style: NeumorphicTheme.currentTheme(context)
                                        .textTheme
                                        .headline4,
                                  )
                                : SizedBox.shrink()
                            : SizedBox.shrink()
                      ],
                    ),
                  ),
                  isMyCourse
                      ? Positioned(
                          top: 45,
                          right: 45,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor:
                                NeumorphicTheme.currentTheme(context)
                                    .accentColor,
                            child: IconButton(
                              color: NeumorphicTheme.currentTheme(context)
                                  .baseColor,
                              onPressed: () {
//                                      Alert(context: null, title: null).show();
                                showModalBottomSheet(
                                    context: context,
                                    builder: (nbm) {
                                      return StatefulBuilder(
                                        builder: (context, setModalState) =>
                                            Container(
                                          height: Provider.of<DeviceDimension>(
                                                      context)
                                                  .height *
                                              0.4,
                                          width: double.infinity,
                                          child: Column(
                                            children: [
                                              Text(
                                                "\nEnter Rating\n",
                                                style: NeumorphicTheme
                                                        .currentTheme(context)
                                                    .textTheme
                                                    .headline1,
                                              ),
                                              StarRating(
                                                size: 35.0,
                                                rating: newRating,
                                                color: Colors.amber,
                                                borderColor: Colors.grey,
                                                starCount: 5,
                                                onRatingChanged: (rating) {
                                                  setModalState(
                                                    () {
                                                      newRating = rating;
                                                    },
                                                  );
                                                  setState(() {
                                                    newRating = rating;
                                                  });
                                                },
                                              ),
                                              NeumorphicButton(
                                                onPressed: () {
                                                  submitOnTap(user.userId);
                                                },
                                                style: NeumorphicTheme
                                                        .currentTheme(context)
                                                    .buttonStyle
                                                    .copyWith(
                                                        color: NeumorphicTheme
                                                                .currentTheme(
                                                                    context)
                                                            .accentColor),
                                                child: Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              padding: EdgeInsets.all(0),
                              iconSize: 20,
                              icon: Icon(
                                Icons.edit,
                              ),
                            ),
                          ),
                        )
                      : SizedBox.shrink()
                ],
              ),
              instructor == null
                  ? SpinKitChasingDots(
                      color: NeumorphicTheme.currentTheme(context).accentColor,
                    )
                  : NeumorphicCard(
                      child: Column(
                        children: [
                          Text(
                            "About the instructor\n",
                            style: NeumorphicTheme.currentTheme(context)
                                .textTheme
                                .headline1,
                          ),
                          ProfilePicture(url: instructor.profilePicURL),
                          SizedBox(height: 10),
                          Text(
                            instructor.name,
                            style: NeumorphicTheme.currentTheme(context)
                                .textTheme
                                .headline3,
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () async {
                              if (await canLaunch(
                                  "mailto:${instructor.email}")) {
                                await launch("mailto:${instructor.email}");
                              } else {
                                throw 'Could not launch';
                              }
                            },
                            child: Text(
                              instructor.email + "\n",
                              style: NeumorphicTheme.currentTheme(context)
                                  .textTheme
                                  .headline3
                                  .copyWith(
                                    decoration: TextDecoration.underline,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
              isMyCourse
                  ? NeumorphicCard(
//                      color: Colors.red,
                      margin:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                      child: RaisedButton.icon(
                        color: NeumorphicTheme.currentTheme(context).baseColor,
                        padding: EdgeInsets.all(10),
                        icon: Icon(UiIcons.money, color: Colors.black),
                        label: Expanded(
                          child: Text(
                            "Ask for refund",
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            softWrap: true,
                            style: NeumorphicTheme.currentTheme(context)
                                .textTheme
                                .headline2
                                .copyWith(color: Colors.grey[900]),
                          ),
                        ),
                        onPressed: () async {
                          if (await canLaunch(
                              "mailto:company.eleventhhour@gmail.com?subject=Requesting refund !&body=\n\nCourse ID : ${widget
                                  .course.id}")) {
                            await launch(
                                "mailto:company.eleventhhour@gmail.com?subject=Requesting refund !&body=\n\nCourse ID : ${widget
                                    .course.id}");
                          } else {
                            throw 'Could not launch';
                          }
                        },
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.all(8),
            color: NeumorphicTheme.currentTheme(context).accentColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                isMyCourse
                    ? RaisedButton.icon(
                        onPressed: () async {
                          Navigator.pushNamed(context, LecturesPage.id,
                              arguments: widget.course);
                        },
                        icon: Icon(FontAwesomeIcons.playCircle),
                        label: Text("Go to course"),
                      )
                    : RaisedButton.icon(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          if (user.cart.contains(widget.course.id)) {
                            await UserController.removeFromCart(
                              userId: user.userId,
                              courseId: widget.course.id,
                            );
                            Provider.of<User>(context, listen: false)
                                .removeCourseFromCart(widget.course.id);
                          } else {
                            await UserController.addToCart(
                              userId: user.userId,
                              courseId: widget.course.id,
                            );
                            Provider.of<User>(context, listen: false)
                                .addCourseToCart(widget.course.id);
                          }

                          setState(() {
                            isLoading = false;
                          });
                        },
                        icon: user.cart.contains(widget.course.id)
                            ? Icon(FontAwesomeIcons.minusCircle)
                            : Icon(FontAwesomeIcons.plusCircle),
                        label: Text(
                          user.cart.contains(widget.course.id)
                              ? "Remove from cart"
                              : "Add to cart",
                        ),
                      ),
                RaisedButton.icon(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });

                    if (isFavorite) {
                      await UserController.removeFromWishlist(
                        userId: user.userId,
                        courseId: widget.course.id,
                      );
                      Provider.of<User>(context, listen: false)
                          .removeCourseFromWishlist(widget.course.id);
                    } else {
                      await UserController.addToWishlist(
                        userId: user.userId,
                        courseId: widget.course.id,
                      );
                      Provider.of<User>(context, listen: false)
                          .addCourseToWishlist(widget.course.id);
                    }

                    setState(() {
                      isLoading = false;
                    });
                  },
                  icon: isFavorite
                      ? Icon(Icons.favorite_border)
                      : Icon(Icons.favorite),
                  label: Text(
                    isFavorite ? "Remove from Fav" : "Add to Fav",
                  ),
                ),
              ],
            ),
          ),
        ),
        isLoading ? LoadingScreen() : SizedBox.shrink(),
      ],
    );
  }

  void submitOnTap(String userId) async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<CourseController>(context, listen: false)
        .updateCourseRating(
      courseId: widget.course.id,
      newRating: {"userId": userId, "userRating": newRating},
      userId: userId,
    );
    setState(() {
      isLoading = false;
    });
    Navigator.pop(context);
  }
}
