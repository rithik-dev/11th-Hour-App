import 'package:cached_network_image/cached_network_image.dart';
import 'package:eleventh_hour/components/LoadingScreen.dart';
import 'package:eleventh_hour/controllers/UserController.dart';
import 'package:eleventh_hour/models/Course.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CourseDetails extends StatefulWidget {
  static const id = '/course_details';
  final Course course;
  User user;

  CourseDetails({@required this.course, @required this.user});

  @override
  _CourseDetailsState createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    widget.user = Provider.of<User>(context);

    return Stack(
      children: [
        Scaffold(
          body: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                height: 250,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: widget.course.courseThumbnail,
                  placeholder: (context, _) => Shimmer.fromColors(
                    child: Container(
                      width: double.infinity,
                    ),
                    baseColor: Colors.grey,
                    highlightColor: Colors.white,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                height: 100,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Text(
                  widget.course.title,
                  style: Theme.of(context).textTheme.headline2,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
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
                    ...widget.course.lectures
                        .map((e) => ListTile(
                              title: Text(e['name']),
                            ))
                        .toList(),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.all(20),
            color: Theme.of(context).primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton.icon(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    if (widget.user.cart.contains(widget.course.id)) {
                      await UserController.removeFromCart(
                        userId: widget.user.userId,
                        courseId: widget.course.id,
                      );
                      Provider.of<User>(context, listen: false)
                          .removeCourseFromCart(widget.course.id);
                    } else {
                      await UserController.addToCart(
                        userId: widget.user.userId,
                        courseId: widget.course.id,
                      );
                      Provider.of<User>(context, listen: false)
                          .addCourseToCart(widget.course.id);
                    }

                    setState(() {
                      isLoading = false;
                    });
                  },
                  icon: widget.user.cart.contains(widget.course.id)
                      ? Icon(FontAwesomeIcons.minusCircle)
                      : Icon(FontAwesomeIcons.plusCircle),
                  label: Text(
                    widget.user.cart.contains(widget.course.id)
                        ? "Remove from cart"
                        : "Add to cart",
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
}