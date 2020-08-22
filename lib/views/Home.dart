import 'package:eleventh_hour/components/DrawerBoilerPlate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';

class Home extends StatefulWidget {
  static const id = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();
  void toggle() {
    _innerDrawerKey.currentState.toggle(direction: InnerDrawerDirection.start);
  }

  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
      innerDrawerKey: _innerDrawerKey,
      scaffold: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              toggle();
            },
          ),
        ),
      ),
    );
  }
}
