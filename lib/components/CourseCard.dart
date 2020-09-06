import 'package:cached_network_image/cached_network_image.dart';
import 'package:eleventh_hour/controllers/UserController.dart';
import 'package:eleventh_hour/models/Course.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:eleventh_hour/views/CourseDetails.dart';
import 'package:eleventh_hour/views/PurchasedCourseDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

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
  Widget build(BuildContext context) {
    isFavorite = widget.user.wishlist.contains(widget.course.id);
    try {
      return Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: GestureDetector(
              onTap: widget.course.blackListed
                  ? null
                  : () {
                      if (widget.user.myCourses.contains(widget.course.id))
                        Navigator.pushNamed(context, PurchasedCourseDetails.id,
                            arguments: widget.course);
                      else
                        Navigator.pushNamed(context, CourseDetails.id,
                            arguments: widget.course);
                    },
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                    decoration: BoxDecoration(
                        color: widget.course.blackListed
                            ? Colors.grey[800]
                            : Colors.grey[300],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 5.0,
                            blurRadius: 5.0,
                          )
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Stack(
                          children: [
                            widget.course.blackListed
                                ? Container(
                                    color: Colors.black,
                                    height: 180.0,
                                    width: double.infinity,
                                    child: Text(
                                      "\n\nThis was blacklisted",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          .copyWith(color: Colors.white),
                                    ),
                                  )
                                : Container(
                                    height: 180.0,
                                    child: CachedNetworkImage(
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      imageUrl:
                                          this.widget.course.courseThumbnail,
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                        child: Container(color: Colors.grey),
                                        baseColor: Colors.grey[300],
                                        highlightColor: Colors.grey,
                                      ),
                                    ),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  .copyWith(color: Colors.black)),
                        ),
                        SizedBox(height: 5.0),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            this.widget.course.instructorName,
                            style: Theme.of(context)
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
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              Text(
                                '⭐ ${this.widget.course.rating.toString()}',
                                style: Theme.of(context).textTheme.headline5,
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
              ? Center(
                  child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                ))
              : SizedBox.shrink(),
        ],
      );
    } catch (err) {
      return Text(err.toString());
    }
  }
}