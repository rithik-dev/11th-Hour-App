import 'package:eleventh_hour/components/DrawerBoilerPlate.dart';
import 'package:eleventh_hour/utilities/UiIcons.dart';
import 'package:eleventh_hour/views/Cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
      screenId: Home.id,
      innerDrawerKey: _innerDrawerKey,
      scaffold: Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
          ]),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                  gap: 8,
                  activeColor: Colors.white,
                  iconSize: 24,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  duration: Duration(milliseconds: 800),
                  tabBackgroundColor: Colors.grey[800],
                  tabs: [
                    GButton(
                      icon: UiIcons.home,
                      text: 'Home',
                    ),
                    GButton(
                      icon: FontAwesomeIcons.video,
                      text: 'My Courses',
                    ),
                    GButton(
                      icon: UiIcons.heart,
                      text: 'Wishlist',
                    ),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  }),
            ),
          ),
        ),
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.id);
              },
            ),
          ],
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
