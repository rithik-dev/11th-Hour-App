import 'package:eleventh_hour/components/DrawerBoilerPlate.dart';
import 'package:eleventh_hour/controllers/CollegeController.dart';
import 'package:eleventh_hour/controllers/CourseController.dart';
import 'package:eleventh_hour/controllers/UserController.dart';
import 'package:eleventh_hour/models/College.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:eleventh_hour/utilities/UiIcons.dart';
import 'package:eleventh_hour/views/Cart.dart';
import 'package:eleventh_hour/views/Home.dart';
import 'package:eleventh_hour/views/MyCoursesScreen.dart';
import 'package:eleventh_hour/views/SearchPage.dart';
import 'package:eleventh_hour/views/WishlistScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class HomeBoilerPlate extends StatefulWidget {
  static const id = '/homeBP';

  @override
  _HomeBoilerPlateState createState() => _HomeBoilerPlateState();
}

class _HomeBoilerPlateState extends State<HomeBoilerPlate> {
  List homeScreenPages = [
    Home(),
    MyCoursesScreen(),
    WishlistScreen(),
    SearchPage()
  ];
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  void toggle() {
    _innerDrawerKey.currentState.toggle(direction: InnerDrawerDirection.start);
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
      screenId: HomeBoilerPlate.id,
      innerDrawerKey: _innerDrawerKey,
      scaffold: SafeArea(
        child: Scaffold(
            bottomNavigationBar: Container(
              decoration: ShapeDecoration(
                color: Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
//              boxShadow: [
//            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1)
//            ),
//          ]
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                child: GNav(
                    gap: 8,
                    activeColor: Colors.white,
                    iconSize: 24,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    duration: Duration(milliseconds: 600),
                    tabBackgroundColor: Colors.grey[800],
                    tabs: [
                      GButton(
                        icon: UiIcons.home,
                        text: 'Home',
                        gap: 20,
                        iconSize: 27,
                        iconColor: Colors.black,
                      ),
                      GButton(
                        icon: UiIcons.video_camera,
                        text: 'Courses',
                        gap: 20,
                        iconSize: 27,
                        iconColor: Colors.black,
                      ),
                      GButton(
                        icon: UiIcons.heart,
                        text: 'Wishlist',
                        gap: 20,
                        iconSize: 27,
                        iconColor: Colors.black,
                      ),
                      GButton(
                        icon: FontAwesomeIcons.search,
                        text: 'Search',
                        gap: 20,
                        iconSize: 24,
                        iconColor: Colors.black,
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
            appBar: AppBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 0,
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
            body: Consumer<User>(
              builder: (context, user, child) {
                return RefreshIndicator(
                  onRefresh: () async {
                    final User newUser =
                        await UserController.getUser(user.userId);
                    final College college =
                        await CollegeController.getCollegeFromId(
                            newUser.collegeId);
                    await Provider.of<CourseController>(context, listen: false)
                        .getCourses();
                    Provider.of<User>(context, listen: false)
                        .updateUserInProvider(newUser);
                    Provider.of<College>(context, listen: false)
                        .updateCollegeInProvider(college);
                  },
                  child: homeScreenPages[_selectedIndex],
                );
              },
            )),
      ),
    );
  }
}
