import 'package:cached_network_image/cached_network_image.dart';
import 'package:eleventh_hour/components/DrawerBoilerPlate.dart';
import 'package:eleventh_hour/controllers/CollegeController.dart';
import 'package:eleventh_hour/models/College.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatelessWidget {
  static const id = '/profile';

  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  void toggle() {
    _innerDrawerKey.currentState.toggle(direction: InnerDrawerDirection.start);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<User>(
        builder: (context, user, child) {
          return CustomDrawer(
            screenId: ProfileScreen.id,
            innerDrawerKey: _innerDrawerKey,
            scaffold: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    toggle();
                  },
                  icon: Icon(Icons.filter_list),
                ),
                title: Text("Profile"),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          ClipOval(
                            child: CachedNetworkImage(
                              width: 100,
                              height: 100,
                              imageUrl: user.profilePicURL,
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
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              backgroundColor: Colors.black,
                              radius: 15.0,
                              child: IconButton(
                                tooltip: "Edit Profile pic",
                                icon: Icon(Icons.edit),
                                color: Colors.white,
                                iconSize: 15.0,
                                onPressed: () {
                                  //TODO: edit image
                                  print("edit profile pic");
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            user.name,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          Text(
                            user.email,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20.0),
                  FutureBuilder(
                    future: CollegeController.getCollegeFromId(user.collegeId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final College college = snapshot.data;
                        return ListTile(
                          title: Text(college.name),
                          subtitle: Text(college.subjectWithCourses.toString()),
                        );
                      } else
                        return Shimmer.fromColors(
                            child: CircleAvatar(),
                            baseColor: Colors.grey,
                            direction: ShimmerDirection.btt,
                            highlightColor: Colors.grey[300]);
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
