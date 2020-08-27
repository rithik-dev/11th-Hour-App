import 'package:cached_network_image/cached_network_image.dart';
import 'package:eleventh_hour/components/DrawerBoilerPlate.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:eleventh_hour/utilities/UiIcons.dart';
import 'package:eleventh_hour/views/Cart.dart';
import 'package:eleventh_hour/views/Home.dart';
import 'package:eleventh_hour/views/MyCoursesScreen.dart';
import 'package:eleventh_hour/views/WishlistScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomeBoilerPlate extends StatefulWidget {
  static const id = '/homeBP';

  @override
  _HomeBoilerPlateState createState() => _HomeBoilerPlateState();
}

class _HomeBoilerPlateState extends State<HomeBoilerPlate> {
  List homeScreenPages = [Home(), MyCoursesScreen(), WishlistScreen()];
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
                      gap: 20,
                      iconSize: 30,
                      iconColor: Colors.black,
                    ),
                    GButton(
                      icon: UiIcons.video_camera,
                      text: 'Courses',
                      gap: 20,
                      iconSize: 30,
                      iconColor: Colors.black,
                    ),
                    GButton(
                      icon: UiIcons.heart,
                      text: 'Wishlist',
                      gap: 20,
                      iconSize: 30,
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
            bottom: PreferredSize(
              preferredSize: _selectedIndex == 0
                  ? Size(MediaQuery.of(context).size.width * 0.98,
                      MediaQuery.of(context).size.height * 0.14)
                  : Size(0, 0),
              child: _selectedIndex == 0
                  ? Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              Provider.of<User>(context).name,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 2,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(fontSize: 36),
                            ),
                          ),
                          ClipOval(
                            child: CachedNetworkImage(
                              width: 90,
                              height: 90,
                              imageUrl:
                                  Provider.of<User>(context).profilePicURL,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Shimmer.fromColors(
                                  child: CircleAvatar(
                                    radius: 50,
                                  ),
                                  baseColor: Colors.grey,
                                  highlightColor: Colors.grey[300]),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox.shrink(),
            ),
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
          body: homeScreenPages[_selectedIndex],
        ),
      ),
    );
  }
}
