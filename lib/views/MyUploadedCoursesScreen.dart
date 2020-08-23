import 'package:eleventh_hour/components/DrawerBoilerPlate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';

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
        body: Center(child: Text("MY UPLOADED COURSES")),
      ),
    );
  }
}
