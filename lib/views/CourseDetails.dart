import 'package:eleventh_hour/components/CachedImage.dart';
import 'package:eleventh_hour/components/CustomVideoPlayer.dart';
import 'package:eleventh_hour/components/LoadingScreen.dart';
import 'package:eleventh_hour/controllers/CourseController.dart';
import 'package:eleventh_hour/controllers/UserController.dart';
import 'package:eleventh_hour/models/Course.dart';
import 'package:eleventh_hour/models/DeviceDimension.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:eleventh_hour/views/LecturesPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

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
    print('Dets $ratings');
    ratings.forEach((rating) {
      _rating += rating['userRating'];
    });
    _rating = _rating / ratings.length;
    return _rating;
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
                height: Provider.of<DeviceDimension>(context).height * 0.14,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
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
                        style: Theme.of(context).textTheme.headline4,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      widget.course.description,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Colors.white),
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
              isMyCourse
                  ? Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                            width: 1,
                          )),
                          margin: EdgeInsets.all(35),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              StarRating(
                                size: 35.0,
                                rating: calcRating(widget.course.ratings),
                                color: Colors.amber,
                                borderColor: Colors.grey,
                                starCount: 5,
                                onRatingChanged: (r) {},
                              ),
                              widget.course.ratings != null
                                  ? haveRated.length != 0
                                      ? Text(
                                          "\nYour Rating: ${haveRated.first['userRating']} ⭐",
                                          style: Theme.of(context)
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
                                top: 25,
                                right: 25,
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  child: IconButton(
                                    color: Theme.of(context).accentColor,
                                    onPressed: () {
//                                      Alert(context: null, title: null).show();
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (nbm) {
                                            return StatefulBuilder(
                                              builder:
                                                  (context, setModalState) =>
                                                      Container(
                                                height:
                                                    Provider.of<DeviceDimension>(
                                                                context)
                                                            .height *
                                                        0.4,
                                                width: double.infinity,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "\nEnter Rating\n",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline1,
                                                    ),
                                                    StarRating(
                                                      size: 35.0,
                                                      rating: newRating,
                                                      color: Colors.amber,
                                                      borderColor: Colors.grey,
                                                      starCount: 5,
                                                      onRatingChanged:
                                                          (rating) {
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
                                                    RaisedButton.icon(
                                                        onPressed: () {
                                                          submitOnTap(
                                                              user.userId);
                                                        },
                                                        icon: Icon(Icons.check),
                                                        label: Text("Submit"))
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    iconSize: 15,
                                    icon: Icon(
                                      Icons.edit,
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox.shrink()
                      ],
                    )
                  : StarRating(
                      size: 35.0,
                      rating: calcRating(widget.course.ratings),
                      color: Colors.amber,
                      borderColor: Colors.grey,
                      starCount: 5,
                      onRatingChanged: (r) {},
                    ),
              widget.course.ratings == null
                  ? Text(
                      "No Ratings Yet",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline3,
                    )
                  : SizedBox.shrink()
            ],
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.all(8),
            color: Theme.of(context).primaryColor,
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
