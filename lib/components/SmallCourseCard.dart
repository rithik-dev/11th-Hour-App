import 'package:cached_network_image/cached_network_image.dart';
import 'package:eleventh_hour/components/CartWishlistToggle.dart';
import 'package:eleventh_hour/models/Course.dart';
import 'package:eleventh_hour/models/DeviceDimension.dart';
import 'package:eleventh_hour/views/CourseDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SmallCourseCard extends StatelessWidget {
  final Course course;
  final bool isWishListPage;

  SmallCourseCard({
    @required this.course,
    this.isWishListPage = false,
  });

  String calcRating(List ratings) {
    if (ratings == null || ratings.length == 0) return "N/A";
    double _rating = 0;

    ratings.forEach((rating) {
      _rating += rating['userRating'];
    });
    _rating = _rating / ratings.length;
    return _rating.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
            color: course.blackListed
                ? Colors.grey[800]
                : NeumorphicTheme.currentTheme(context).baseColor),
        child: ListTile(
            onLongPress: () async {
              showModalBottomSheet(
                  context: context,
                  builder: (context) =>
                      CartWishlistToggle(courseId: course.id));
            },
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(width: 1.0, color: Colors.white24))),
              child: course.blackListed
                  ? Container(
                      color: Colors.black,
                      height:
                          Provider.of<DeviceDimension>(context).height * 0.1,
                      width: Provider.of<DeviceDimension>(context).width * 0.22,
                      child: Text(
                        "BLACK\nLISTED",
                        textAlign: TextAlign.center,
                        style: NeumorphicTheme.currentTheme(context)
                            .textTheme
                            .subtitle1,
                      ),
                    )
                  : CachedNetworkImage(
                      imageUrl: course.courseThumbnail,
                      height:
                          Provider.of<DeviceDimension>(context).height * 0.1,
                      width: Provider.of<DeviceDimension>(context).width * 0.22,
                      fit: BoxFit.cover,
                      errorWidget: (context, i, l) => Icon(Icons.error),
                      placeholder: (c, u) => Shimmer.fromColors(
                          child: Container(),
                          baseColor: Colors.white,
                          highlightColor: Colors.grey),
                    ),
            ),
            title: Text(course.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:
                    NeumorphicTheme.currentTheme(context).textTheme.headline5),
            subtitle: Text(
              'Rs. ${course.price} | ⭐ ${calcRating(course.ratings)}',
              style: NeumorphicTheme.currentTheme(context)
                  .textTheme
                  .headline5
                  .copyWith(fontSize: 17),
            ),
            onTap: !course.blackListed
                ? () {
                    Navigator.pushNamed(context, CourseDetails.id,
                        arguments: course);
                  }
                : () {
                    Fluttertoast.showToast(msg: "BlackListed");
                  },
            trailing: course.blackListed
                ? Icon(
                    Icons.error,
                    color: Colors.black38,
                    size: 30.0,
                  )
                : Icon(Icons.keyboard_arrow_right,
                    color: Colors.black, size: 30.0)),
      ),
    );
  }
}
