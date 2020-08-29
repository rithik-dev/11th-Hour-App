import 'package:cached_network_image/cached_network_image.dart';
import 'package:eleventh_hour/models/Course.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CourseCard extends StatelessWidget {
  final Course course;

  CourseCard({this.course});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          print("course page");
        },
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
              decoration: BoxDecoration(color: Colors.grey[300], boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 5.0,
                  blurRadius: 5.0,
                )
              ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 200.0,
                    child: CachedNetworkImage(
                      width: double.infinity,
                      fit: BoxFit.cover,
                      imageUrl: this.course.courseThumbnail,
                      placeholder: (context, url) => Shimmer.fromColors(
                        child: Container(color: Colors.grey),
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      this.course.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      this.course.instructorName,
                      style: TextStyle(fontSize: 14.0, color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Rs ${this.course.price}/- ",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 19.0),
                        ),
                        Container(
                          height: 40.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.grey.withOpacity(0.2)),
                          child: Center(
                            child: IconButton(
                              icon: Icon(Icons.favorite),
                              color: Colors.red,
                              onPressed: () {
                                print("add to fav");
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0)
                ],
              )),
        ),
      ),
    );
  }
}
