import 'dart:io';

import 'package:eleventh_hour/components/LoadingScreen.dart';
import 'package:eleventh_hour/components/NeumoCard.dart';
import 'package:eleventh_hour/components/ProfilePicture.dart';
import 'package:eleventh_hour/controllers/UserController.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:eleventh_hour/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfilePictureScreen extends StatefulWidget {
  @override
  _EditProfilePictureScreenState createState() =>
      _EditProfilePictureScreenState();
}

enum ImageSelected { currentImage, defaultImage, newImage }

class _EditProfilePictureScreenState extends State<EditProfilePictureScreen> {
  final ImagePicker imagePicker = ImagePicker();
  double imageRadius = 60;
  ImageSelected imageSelected = ImageSelected.currentImage;
  bool isLoading = false;

  File _image;

  Future getImage(ImageSource source) async {
    final pickedFile = await imagePicker.getImage(source: source);
    if (pickedFile == null) return;
    setState(() {
      imageSelected = ImageSelected.newImage;
      _image = File(pickedFile.path);
    });
  }

  CircleAvatar _getAvatar(String profilePicURL) {
    switch (imageSelected) {
      case ImageSelected.newImage:
        return CircleAvatar(
          radius: this.imageRadius,
          backgroundImage: FileImage(_image),
        );
      case ImageSelected.defaultImage:
        return CircleAvatar(
          radius: this.imageRadius,
          backgroundImage: AssetImage(
            'assets/images/userDefault.jpeg',
          ),
        );
      case ImageSelected.currentImage:
        return CircleAvatar(
          radius: this.imageRadius,
          child: ProfilePicture(
            url: profilePicURL,
            radius: this.imageRadius,
          ),
        );
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<User>(
      builder: (context, user, child) {
        return Scaffold(
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(height: 50.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _getAvatar(user.profilePicURL),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.camera_alt),
                              iconSize: 40,
                              color: NeumorphicTheme.currentTheme(context)
                                  .accentColor,
                              onPressed: () => getImage(ImageSource.camera),
                            ),
                            IconButton(
                              icon: Icon(Icons.photo),
                              iconSize: 40,
                              color: NeumorphicTheme.currentTheme(context)
                                  .accentColor,
                              onPressed: () => getImage(ImageSource.gallery),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Builder(
                      builder: (context) {
                        return NeumorphicCard(
                          child: RaisedButton.icon(
                            color:
                                NeumorphicTheme.currentTheme(context).baseColor,
                            elevation: 0,
                            icon: Icon(FontAwesomeIcons.upload),
                            label: Text("Upload Picture"),
                            onPressed: () async {
                              if (_image != null) {
                                setState(() {
                                  isLoading = true;
                                });
                                final String newUrl =
                                    await UserController.updateProfilePicture(
                                        newImage: _image,
                                        oldImageURL: user.profilePicURL,
                                        userId: user.userId);
                                user.profilePicURL = newUrl;
                                user.updateUserInProvider(user);
                                await _image.delete();
                                Navigator.pop(context);

                                setState(() {
                                  isLoading = false;
                                });

                                Fluttertoast.showToast(
                                    msg: "Profile Picture Updated");
                              } else
                                Fluttertoast.showToast(
                                    msg: "Please Select an Image !");
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10.0),
                    Builder(
                      builder: (context) {
                        return NeumorphicCard(
                          child: RaisedButton.icon(
                            color:
                                NeumorphicTheme.currentTheme(context).baseColor,
                            elevation: 0,
                            icon: Icon(Icons.remove),
                            label: Text("Remove Picture"),
                            onPressed: () async {
                              if (user.profilePicURL != kDefaultProfilePicUrl) {
                                setState(() {
                                  isLoading = true;
                                });

                                final String defaultUrl =
                                    await UserController.removeProfilePicture(
                                        userId: user.userId,
                                        oldImageURL: user.profilePicURL);
                                Navigator.pop(context);
                                user.profilePicURL = defaultUrl;
                                user.updateUserInProvider(user);

                                setState(() {
                                  isLoading = false;
                                });

                                Fluttertoast.showToast(
                                    msg: "Profile Picture Removed");
                              } else {
                                Fluttertoast.showToast(
                                    msg:
                                        "Profile picture is already removed !");
                              }
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 30.0),
                  ],
                ),
              ),
              isLoading ? LoadingScreen() : SizedBox.shrink(),
            ],
          ),
        );
      },
    );
  }
}
