import 'package:eleventh_hour/components/DrawerBoilerPlate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';

class WishlistScreen extends StatelessWidget {
  static const id = '/wishlist';
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  void toggle() {
    _innerDrawerKey.currentState.toggle(direction: InnerDrawerDirection.start);
  }

  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
      screenId: WishlistScreen.id,
      innerDrawerKey: _innerDrawerKey,
      scaffold: Scaffold(
        backgroundColor: Colors.lightGreenAccent,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              toggle();
            },
            icon: Icon(Icons.filter_list),
          ),
          title: Text("Wishlist"),
        ),
        body: Center(child: Text("WISHLIST")),
      ),
    );
  }
}
