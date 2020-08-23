import 'package:eleventh_hour/components/DrawerBoilerPlate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';

class MyCoursesScreen extends StatelessWidget {
  static const id = '/my_courses';
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  void toggle() {
    _innerDrawerKey.currentState.toggle(direction: InnerDrawerDirection.start);
  }

  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
      screenId: MyCoursesScreen.id,
      innerDrawerKey: _innerDrawerKey,
      scaffold: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              toggle();
            },
            icon: Icon(Icons.filter_list),
          ),
          title: Text("MY COURSES"),
        ),
        body: Center(child: Text("MY COURSES")),
      ),
    );
  }
}
