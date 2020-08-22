import 'package:cached_network_image/cached_network_image.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:eleventh_hour/utilities/UiIcons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  static const id = '/profile';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Consumer<User>(
          builder: (context, user, child) {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                tooltip: "Add to favourites",
                child: Icon(UiIcons.favorites),
              ),
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
                        Container(
                          margin: EdgeInsets.all(20),
                          child: Stack(
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
                                  backgroundColor: Colors.grey,
                                  radius: 15.0,
                                  child: IconButton(
                                    icon: Icon(Icons.edit),
                                    iconSize: 15.0,
                                    onPressed: () {
                                      //TODO: edit image
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        TabBar(
                          tabs: [
                            Text("Instagram"),
                            Text("Facebook"),
                            Text("Youtube"),
                          ],
                        ),
                      ],
                    ),
                  )),
              body: Container(
                margin: EdgeInsets.all(20),
                child: TabBarView(
                  children: [
                    Text("Instagram"),
                    Text("Facebook"),
                    Text("Youtube"),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
