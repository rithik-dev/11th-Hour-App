import 'dart:io';

import 'package:eleventh_hour/components/DrawerBoilerPlate.dart';
import 'package:eleventh_hour/components/EditProfilePictureScreen.dart';
import 'package:eleventh_hour/components/ProfilePicture.dart';
import 'package:eleventh_hour/controllers/UserController.dart';
import 'package:eleventh_hour/models/College.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static const id = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://eleventhhour-eb2e0.appspot.com');

  final picker = ImagePicker();

  File _image;

  bool imageSelected = false;

  bool isLoading = false;

  bool isAsyncCall = false;
  String _profilePicURL;

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile == null) return;
    setState(() {
      imageSelected = true;
      _image = File(pickedFile.path);
    });
  }

  Future uploadFile() async {
    String userId = Provider.of<User>(context).userId;

    StorageUploadTask uploadTask =
        _storage.ref().child('Profile Pictures/$userId.png').putFile(_image);
    await uploadTask.onComplete;
    String fileURL = await _storage
        .ref()
        .child('Profile Pictures/$userId.png')
        .getDownloadURL();
    setState(() {
      _profilePicURL = fileURL;
    });
  }

  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  void toggle() {
    _innerDrawerKey.currentState.toggle(direction: InnerDrawerDirection.start);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer2<User, College>(
        builder: (context, user, college, child) {
          return CustomDrawer(
            screenId: ProfileScreen.id,
            innerDrawerKey: _innerDrawerKey,
            scaffold: RefreshIndicator(
              onRefresh: () async {
                final User newUser = await UserController.getUser(user.userId);
                Provider.of<User>(context, listen: false)
                    .updateUserInProvider(newUser);
              },
              child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () {
                      toggle();
                    },
                    icon: Icon(Icons.filter_list),
                  ),
                  title: Text("Profile"),
                ),
                body: ListView(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            ProfilePicture(url: user.profilePicURL, radius: 55),
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
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) =>
                                            EditProfilePictureScreen());
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
                              maxLines: 2,
                              softWrap: true,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20.0),
                    ListTile(
                      title: Text(college.name),
                      subtitle: Text(college.subjectWithCourses.toString()),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
