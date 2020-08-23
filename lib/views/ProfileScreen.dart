import 'package:cached_network_image/cached_network_image.dart';
import 'package:eleventh_hour/components/DrawerBoilerPlate.dart';
import 'package:eleventh_hour/controllers/CollegeController.dart';
import 'package:eleventh_hour/models/College.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  static const id = '/profile';

  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<User>(
        builder: (context, user, child) {
          return CustomDrawer(
            innerDrawerKey: _innerDrawerKey,
            scaffold: Scaffold(
              appBar: PreferredSize(
                  preferredSize: Size(double.infinity,
                      MediaQuery.of(context).size.height * 0.4),
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Text(
                          user.name,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Stack(
                          children: <Widget>[
                            ClipOval(
                              child: CachedNetworkImage(
                                width: 100,
                                height: 100,
                                imageUrl: user.profilePicURL,
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
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
                      ],
                    ),
                  )),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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
                        return CircularProgressIndicator();
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
