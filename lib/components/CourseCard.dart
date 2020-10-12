import 'package:eleventh_hour/components/CachedImage.dart';
import 'package:eleventh_hour/components/NeumoCard.dart';
import 'package:eleventh_hour/controllers/UserController.dart';
import 'package:eleventh_hour/models/Course.dart';
import 'package:eleventh_hour/models/DeviceDimension.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:eleventh_hour/views/CourseDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class CourseCard extends StatefulWidget {
  final Course course;
  final User user;

  CourseCard({@required this.course, @required this.user});

  @override
  _CourseCardState createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  bool isLoading = false;
  bool isFavorite;

  String calcRating(List ratings) {
    if (ratings == null || ratings.length == 0) return "N/A";
    double _rating = 0;
    ratings.forEach((rating) {
      _rating += rating['userRating'];
    });
    _rating = _rating / ratings.length;
    return _rating.toStringAsFixed(1);
  }

  void _onPressed() async {
    setState(() {
      isLoading = true;
    });

    if (isFavorite) {
      await UserController.removeFromWishlist(
        userId: widget.user.userId,
        courseId: widget.course.id,
      );
      Provider.of<User>(context, listen: false)
          .removeCourseFromWishlist(widget.course.id);
    } else {
      await UserController.addToWishlist(
        userId: widget.user.userId,
        courseId: widget.course.id,
      );
      Provider.of<User>(context, listen: false)
          .addCourseToWishlist(widget.course.id);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isFavorite = widget.user.wishlist.contains(widget.course.id);

    return Stack(
      children: [
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: GestureDetector(
            onTap: widget.course.blackListed
                ? null
                : () {
                    Navigator.pushNamed(context, CourseDetails.id,
                        arguments: widget.course);
                  },
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: NeumorphicCard(
                  margin: EdgeInsets.all(0),
//                  decoration: BoxDecoration(
//                    color: widget.course.blackListed
//                        ? Colors.grey[800]
//                        : NeumorphicTheme.baseColor(context),
//                  ),
//                      boxShadow: [
//                        BoxShadow(
////                          color: Colors.black.withOpacity(0.5),
//                          spreadRadius: 5.0,
//                          blurRadius: 5.0,
//                        )
//                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: [
                          widget.course.blackListed
                              ? Container(
                                  color: Colors.black,
                                  height: Provider.of<DeviceDimension>(context)
                                          .height *
                                      0.22,
                                  width: double.infinity,
                                  child: Text(
                                    "\n\nThis was blacklisted",
                                    textAlign: TextAlign.center,
                                    style: NeumorphicTheme.currentTheme(context)
                                        .textTheme
                                        .headline5
                                        .copyWith(color: Colors.black),
                                  ),
                                )
                              : Container(
                                  height: Provider.of<DeviceDimension>(context)
                                          .height *
                                      0.22,
//                                  height: 200,
                                  child: CachedImage(
                                    url: widget.course.courseThumbnail,
                                  ),
//                                  color: Colors.red,
                                ),
                          widget.course.blackListed
                              ? SizedBox.shrink()
                              : Positioned(
                                  right: 10,
                                  top: 10,
                                  child: Bounce(
                                    duration: Duration(milliseconds: 500),
                                    onPressed: isLoading
                                        ? null
                                        : widget.course.blackListed
                                            ? null
                                            : _onPressed,
                                    child: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      size: 30,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      SizedBox(height: 15.0),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(this.widget.course.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: NeumorphicTheme.currentTheme(context)
                                .textTheme
                                .headline2
                                .copyWith(color: Colors.black)),
                      ),
                      SizedBox(height: 5.0),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          this.widget.course.instructorName,
                          style: NeumorphicTheme.currentTheme(context)
                              .textTheme
                              .headline4
                              .copyWith(color: Colors.black54),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Rs ${this.widget.course.price}/- ",
                              style: NeumorphicTheme.currentTheme(context)
                                  .textTheme
                                  .headline5,
                            ),
                            Text(
                              '⭐ ${calcRating(widget.course.ratings)}',
                              style: NeumorphicTheme.currentTheme(context)
                                  .textTheme
                                  .headline5,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  )),
            ),
          ),
        ),
        isLoading
            ? Center(child: CircularProgressIndicator())
            : SizedBox.shrink(),
      ],
    );
  }
}
