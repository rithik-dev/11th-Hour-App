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
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class HomeBoilerPlate extends StatefulWidget {
  static const id = '/homeBP';

  @override
  _HomeBoilerPlateState createState() => _HomeBoilerPlateState();
}

class _HomeBoilerPlateState extends State<HomeBoilerPlate> {
  Widget returnHomePages(int index) {
    List<Widget> widgets = [
      Home(
        callback: callback,
      ),
      MyCoursesScreen(),
      WishlistScreen(),
      SearchPage()
    ];
    return widgets[index];
  }

  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  void toggle() {
    _innerDrawerKey.currentState.toggle(direction: InnerDrawerDirection.start);
  }

  int _selectedIndex = 0;

  callback(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
      screenId: HomeBoilerPlate.id,
      innerDrawerKey: _innerDrawerKey,
      scaffold: SafeArea(
        child: Scaffold(
            bottomNavigationBar: Container(
              decoration: ShapeDecoration(
                color: Colors.white60,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
//              boxShadow: [
//            BoxShadow(blurRadius: 17, color: Colors.black.withOpacity(.1)
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
                    padding: EdgeInsets.symmetric(horizontal: 17, vertical: 5),
                    duration: Duration(milliseconds: 300),
                    tabBackgroundColor: Colors.grey[800],
                    tabs: [
                      GButton(
                        icon: UiIcons.home,
                        text: 'Home',
                        gap: 17,
                        iconSize: 27,
                        iconColor: Colors.black,
                      ),
                      GButton(
                        icon: UiIcons.video_camera,
                        text: 'Courses',
                        gap: 17,
                        iconSize: 27,
                        iconColor: Colors.black,
                      ),
                      GButton(
                        icon: UiIcons.heart,
                        text: 'Wishlist',
                        gap: 17,
                        iconSize: 27,
                        iconColor: Colors.black,
                      ),
                      GButton(
                        icon: Icons.search,
                        text: 'Search',
                        gap: 17,
                        iconSize: 27,
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
            appBar: NeumorphicAppBar(
              buttonStyle: NeumorphicTheme.currentTheme(context).buttonStyle,
              centerTitle: true,
              actions: [
                NeumorphicButton(
                  padding: EdgeInsets.all(0),
                  drawSurfaceAboveChild: false,
                  style: NeumorphicTheme.currentTheme(context).buttonStyle,
                  child: Stack(
                    children: [
                      Positioned(
                        child: Icon(
                          Icons.shopping_cart,
                          size: 25,
                        ),
                        right: 0,
                        left: 0,
                        bottom: 0,
                        top: 0,
                      ),
                      Positioned(
                        top: 8.5,
                        right: 7.9,
                        child: CircleAvatar(
                          radius: 8,
                          child: Text(
                            "${Provider.of<User>(context).cart.length}",
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      )
                    ],
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, CartScreen.id);
                  },
                ),
              ],
              leading: NeumorphicButton(
                style: NeumorphicTheme.currentTheme(context).buttonStyle,
                child: Icon(Icons.filter_list),
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
                  child: returnHomePages(_selectedIndex),
                );
              },
            )),
      ),
    );
  }
}
