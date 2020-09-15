import 'package:eleventh_hour/components/NoSearchResults.dart';
import 'package:eleventh_hour/components/NoSearchText.dart';
import 'package:eleventh_hour/components/SmallCourseCard.dart';
import 'package:eleventh_hour/controllers/CourseController.dart';
import 'package:eleventh_hour/models/Course.dart';
import 'package:eleventh_hour/models/DeviceDimension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SearchPage extends StatefulWidget {
  static const id = '/search';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Course> searchResults = [];

  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CourseController>(builder: (context, courses, child) {
      return Scaffold(
        body: Column(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                width: Provider.of<DeviceDimension>(context).width * 0.9,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30)),
                child: TextField(
                  controller: _controller,
                  onChanged: (String value) {
                    setState(() {
                      searchResults = courses.courses
                          .where((element) => element.title
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                  decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(Icons.search,
                            size: 30, color: Colors.deepOrange),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.cancel, size: 25, color: Colors.grey),
                        splashRadius: 1,
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          setState(() {
                            _controller.clear();
                          });
                        },
                      ),
                      border: InputBorder.none,
                      hintText: "Search",
                      hintStyle:
                          TextStyle(color: Colors.grey[600], fontSize: 20)),
                ),
              ),
            ),
            _controller.text == ""
                ? NoSearchText()
                : searchResults.length == 0
                    ? NoSearchResults()
                    : Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return SmallCourseCard(
                              course: searchResults[index],
                            );
                          },
                          itemCount: searchResults.length,
                        ),
                      )
          ],
        ),
      );
    });
  }
}
