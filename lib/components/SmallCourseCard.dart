import 'package:cached_network_image/cached_network_image.dart';
import 'package:eleventh_hour/models/Course.dart';
import 'package:eleventh_hour/views/CourseDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';

class SmallCourseCard extends StatelessWidget {
  final Course course;
  final bool isWishListPage;
  SmallCourseCard({@required this.course, this.isWishListPage = false});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
            color: course.blackListed
                ? Colors.grey
                : Color.fromRGBO(64, 75, 96, .9)),
        child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: BoxDecoration(
                  border: Border(
                      right: BorderSide(width: 1.0, color: Colors.white24))),
              child: CachedNetworkImage(
                imageUrl: course.courseThumbnail,
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
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.white)),
            subtitle: Text(
              'Rs. ${course.price} | ⭐ ${course.rating.toString()}',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontSize: 17, color: Colors.grey[300]),
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
                    color: Colors.white,
                    size: 30.0,
                  )
                : Icon(Icons.keyboard_arrow_right,
                    color: Colors.white, size: 30.0)),
      ),
    );
  }
}
