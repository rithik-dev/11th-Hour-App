import 'package:eleventh_hour/components/NeumoCard.dart';
import 'package:eleventh_hour/components/NoSearchResults.dart';
import 'package:eleventh_hour/components/NoSearchText.dart';
import 'package:eleventh_hour/components/SmallCourseCard.dart';
import 'package:eleventh_hour/controllers/CourseController.dart';
import 'package:eleventh_hour/models/Course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
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
              child: NeumorphicCard(
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
                          TextStyle(color: Colors.grey[600], fontSize: 18)),
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
