import 'package:eleventh_hour/components/404Card.dart';
import 'package:eleventh_hour/components/DrawerBoilerPlate.dart';
import 'package:eleventh_hour/controllers/CourseController.dart';
import 'package:eleventh_hour/controllers/UserController.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:provider/provider.dart';

class MyUploadedCoursesScreen extends StatelessWidget {
  static const id = '/my_uploaded_courses';
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  void toggle() {
    _innerDrawerKey.currentState.toggle(direction: InnerDrawerDirection.start);
  }


  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
      screenId: MyUploadedCoursesScreen.id,
      innerDrawerKey: _innerDrawerKey,
      scaffold: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              toggle();
            },
            icon: Icon(Icons.filter_list),
          ),
          title: Text("MY UPLOADED COURSES"),
        ),
        body: Consumer2<User, CourseController>(
            builder: (context, user, course, child) {
              return RefreshIndicator(
                onRefresh: () async {
                  final User newUser = await UserController.getUser(
                      user.userId);
                  Provider.of<User>(context, listen: false)
                      .updateUserInProvider(newUser);
                },
                child: (user.myUploadedCourses == null ||
                    user.myUploadedCourses.length == 0)
                    ? Card404(title: "UPLOADED COURSES")
                    : Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: ListView(
                          children: [
                            Text("uploaded COurses")
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
