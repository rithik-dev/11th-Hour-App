import 'dart:io';

import 'package:eleventh_hour/components/CollegeDropdown.dart';
import 'package:eleventh_hour/components/DrawerBoilerPlate.dart';
import 'package:eleventh_hour/components/EditProfilePictureScreen.dart';
import 'package:eleventh_hour/components/NeumoCard.dart';
import 'package:eleventh_hour/components/ProfilePicture.dart';
import 'package:eleventh_hour/controllers/CollegeController.dart';
import 'package:eleventh_hour/controllers/UserController.dart';
import 'package:eleventh_hour/models/College.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:eleventh_hour/utilities/UiIcons.dart';
import 'package:eleventh_hour/utilities/constants.dart';
import 'package:eleventh_hour/views/MyTransactionsHistory.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ProfileScreen extends StatefulWidget {
  static const id = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://th-hour-de18e.appspot.com');

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

  List<College> colleges = [];

  Future<List<College>> _fetchColleges() async {
    colleges = await CollegeController.getColleges();
    return colleges;
  }

  College _selectedCollege;
  Future _future;

  final _changePasswordFormKey = GlobalKey<FormState>();
  final _changeEmailFormKey = GlobalKey<FormState>();
  final _changeNameAndPhoneFormKey = GlobalKey<FormState>();

  final TextEditingController alertPasswordController = TextEditingController();
  final TextEditingController alertNewPasswordController =
      TextEditingController();
  final TextEditingController alertConfirmPasswordController =
      TextEditingController();

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newEmailController = TextEditingController();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  College _currentCollege;

  List<DropdownMenuItem<College>> get _dropDownItems {
    List<DropdownMenuItem<College>> items = [];
    for (int index = 0; index < colleges.length; index++) {
      if (colleges[index].name != "Other")
        items.add(
          DropdownMenuItem<College>(
            child: Text(colleges[index].name),
            value: colleges[index],
          ),
        );
    }
    return items;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = _fetchColleges();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    oldPasswordController.dispose();
    alertConfirmPasswordController.dispose();
    alertPasswordController.dispose();
    alertNewPasswordController.dispose();
    phoneController.dispose();
    nameController.dispose();
    newEmailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _currentCollege = Provider.of<College>(context);
    return SafeArea(
      child: Consumer2<User, College>(
        builder: (context, user, college, child) {
//          nameController.text = user.name;
//          phoneController.text = user.phone;
          return CustomDrawer(
            screenId: ProfileScreen.id,
            innerDrawerKey: _innerDrawerKey,
            scaffold: RefreshIndicator(
              onRefresh: () async {
                final User newUser = await UserController.getUser(user.userId);
                final College college =
                    await CollegeController.getCollegeFromId(newUser.collegeId);
                Provider.of<User>(context, listen: false)
                    .updateUserInProvider(newUser);
                Provider.of<College>(context, listen: false)
                    .updateCollegeInProvider(college);
              },
              child: Scaffold(
                appBar: NeumorphicAppBar(
                  leading: NeumorphicButton(
                    onPressed: () {
                      toggle();
                    },
                    child: Icon(Icons.filter_list),
                  ),
                  title: NeumorphicText(
                    "Profile",
                    style: NeumorphicStyle(color: Colors.black),
                    textStyle: NeumorphicTextStyle(fontSize: 20),
                  ),
                ),
                body: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overScroll) {
                    overScroll.disallowGlow();
                    return;
                  },
                  child: ListView(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      NeumorphicCard(
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              leading: Icon(UiIcons.user_1),
                              title: Text(
                                'Profile Settings',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                            Stack(
                              children: <Widget>[
                                ProfilePicture(
                                    url: user.profilePicURL, radius: 55),
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
                            Stack(
                              children: [
                                NeumorphicCard(
                                  margin: EdgeInsets.all(15),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        onTap: () {},
                                        dense: true,
                                        title: Text(
                                          'Name',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                        trailing: Text(
                                          user.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        ),
                                      ),
                                      ListTile(
                                        onTap: () {},
                                        dense: true,
                                        title: Text(
                                          ('Phone Number'),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                        trailing: Text(
                                          (user.phone),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.black,
                                    child: IconButton(
                                      padding: EdgeInsets.all(0),
                                      icon: Icon(Icons.edit),
                                      onPressed: () async {
                                        showAlert(
                                          content: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6, bottom: 20.0),
                                                child: Form(
                                                  key:
                                                      _changeNameAndPhoneFormKey,
                                                  child: Column(
                                                    children: [
                                                      TextFormField(
                                                          controller:
                                                              nameController,
                                                          decoration: kTextFieldDecoration
                                                              .copyWith(
                                                                  prefixIcon:
                                                                      Icon(UiIcons
                                                                          .message_1),
                                                                  hintText:
                                                                      "Enter name",
                                                                  labelText:
                                                                      "Name"),
                                                          onChanged: (value) {},
                                                          validator: (value) {
                                                            if (value.isEmpty) {
                                                              return 'Please enter your name';
                                                            }
                                                            return null;
                                                          }),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      TextFormField(
                                                          controller:
                                                              phoneController,
                                                          decoration: kTextFieldDecoration.copyWith(
                                                              prefixIcon: Icon(
                                                                  UiIcons
                                                                      .phone_call),
                                                              hintText:
                                                                  "Enter phone",
                                                              labelText:
                                                                  "Phone"),
                                                          onChanged: (value) {},
                                                          validator: (value) {
                                                            if (value.isEmpty) {
                                                              return 'Please enter your phone number';
                                                            }
                                                            return null;
                                                          }),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          context: context,
                                          onPressed: () async {
                                            if (_changeNameAndPhoneFormKey
                                                .currentState
                                                .validate()) {
                                              Fluttertoast.showToast(
                                                  msg: "Changing...",
                                                  backgroundColor: Colors.black,
                                                  textColor: Colors.white);

                                              try {
                                                await UserController
                                                    .updateNameAndPhone(
                                                  name: nameController.text,
                                                  phone: phoneController.text,
                                                  userId: user.userId,
                                                );

                                                user.name = nameController.text;
                                                user.phone =
                                                    phoneController.text;
                                                user.updateUserInProvider(user);
                                                Navigator.pop(context);
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "Details updated successfully");
                                              } catch (e) {
                                                Fluttertoast.showToast(
                                                  msg: e.message,
                                                  backgroundColor: Colors.black,
                                                  textColor: Colors.white,
                                                );
                                              }
                                            }
                                          },
                                          heading: "Change Name or Phone",
                                          buttonText: "Change",
                                        );
                                      },
                                      iconSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Email",
                                    style: NeumorphicTheme.currentTheme(context)
                                        .textTheme
                                        .headline6,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        (user.email),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        color: Colors.black,
                                        onPressed: () {
                                          showAlert(
                                            content: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 6, bottom: 20.0),
                                                  child: Form(
                                                    key: _changeEmailFormKey,
                                                    child: Column(
                                                      children: [
                                                        TextFormField(
                                                            controller:
                                                                newEmailController,
                                                            decoration: kTextFieldDecoration.copyWith(
                                                                prefixIcon:
                                                                    Icon(UiIcons
                                                                        .message_1),
                                                                hintText:
                                                                    "Enter new email",
                                                                labelText:
                                                                    "New Email"),
                                                            onChanged:
                                                                (value) {},
                                                            validator: (value) {
                                                              if (value
                                                                  .isEmpty) {
                                                                return 'Please enter your email';
                                                              }
                                                              return null;
                                                            }),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        TextFormField(
                                                            obscureText: true,
                                                            controller:
                                                                oldPasswordController,
                                                            keyboardType:
                                                                TextInputType
                                                                    .visiblePassword,
                                                            decoration: kTextFieldDecoration.copyWith(
                                                                prefixIcon:
                                                                    Icon(UiIcons
                                                                        .padlock_1),
                                                                hintText:
                                                                    "Enter password",
                                                                labelText:
                                                                    "Password"),
                                                            onChanged:
                                                                (value) {},
                                                            validator: (value) {
                                                              if (value
                                                                  .isEmpty) {
                                                                return 'Please enter your password';
                                                              } else if (value
                                                                      .length <
                                                                  6) {
                                                                return 'Min Length should be 6';
                                                              }
                                                              return null;
                                                            }),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            context: context,
                                            onPressed: () async {
                                              if (_changeEmailFormKey
                                                  .currentState
                                                  .validate()) {
                                                Fluttertoast.showToast(
                                                    msg: "Changing...",
                                                    backgroundColor:
                                                        Colors.black,
                                                    textColor: Colors.white);

                                                try {
                                                  await UserController
                                                      .changeCurrentUserEmail(
                                                    oldPassword:
                                                        oldPasswordController
                                                            .text,
                                                    newEmail: newEmailController
                                                        .text
                                                        .trim(),
                                                  );
                                                  user.email =
                                                      newEmailController.text
                                                          .trim();
                                                  user.updateUserInProvider(
                                                      user);
                                                  newEmailController.clear();
                                                  oldPasswordController.clear();
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Email changed successfully . Please verify new email..");
                                                  Navigator.pop(context);
                                                } catch (e) {
                                                  Fluttertoast.showToast(
                                                    msg: e.message,
                                                    backgroundColor:
                                                        Colors.black,
                                                    textColor: Colors.white,
                                                  );
                                                }
                                              }
                                            },
                                            heading: "Change Email",
                                            buttonText: "Change",
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                showAlert(
                                  content: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 6, bottom: 20.0),
                                        child: Form(
                                          key: _changePasswordFormKey,
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                  obscureText: true,
                                                  controller:
                                                      alertPasswordController,
                                                  keyboardType: TextInputType
                                                      .visiblePassword,
                                                  decoration: kTextFieldDecoration
                                                      .copyWith(
                                                          prefixIcon: Icon(
                                                              UiIcons.padlock),
                                                          hintText:
                                                              "Enter old password",
                                                          labelText:
                                                              "Old Password"),
                                                  onChanged: (value) {},
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return 'Please enter your old password';
                                                    } else if (value.length <
                                                        6) {
                                                      return 'Min Length should be 6';
                                                    }
                                                    return null;
                                                  }),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              TextFormField(
                                                  obscureText: true,
                                                  controller:
                                                      alertNewPasswordController,
                                                  keyboardType: TextInputType
                                                      .visiblePassword,
                                                  decoration: kTextFieldDecoration
                                                      .copyWith(
                                                          prefixIcon: Icon(
                                                              UiIcons
                                                                  .padlock_1),
                                                          hintText:
                                                              "Enter new password",
                                                          labelText:
                                                              "New Password"),
                                                  onChanged: (value) {},
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return 'Please enter your new password';
                                                    } else if (value.length <
                                                        6) {
                                                      return 'Min Length should be 6';
                                                    }
                                                    return null;
                                                  }),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              TextFormField(
                                                  obscureText: true,
                                                  controller:
                                                      alertConfirmPasswordController,
                                                  keyboardType: TextInputType
                                                      .visiblePassword,
                                                  decoration: kTextFieldDecoration
                                                      .copyWith(
                                                          prefixIcon: Icon(
                                                              UiIcons
                                                                  .padlock_1),
                                                          hintText:
                                                              "Re-enter new password",
                                                          labelText:
                                                              "Confirm Password"),
                                                  onChanged: (value) {},
                                                  validator: (value) {
                                                    if (value.isEmpty) {
                                                      return 'Please confirm your password';
                                                    } else if (value.length <
                                                        6) {
                                                      return 'Min Length should be 6';
                                                    } else if (value !=
                                                        alertNewPasswordController
                                                            .text) {
                                                      return "New password doesn't match";
                                                    }
                                                    return null;
                                                  })
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  context: context,
                                  onPressed: () async {
                                    if (_changePasswordFormKey.currentState
                                        .validate()) {
                                      Fluttertoast.showToast(
                                          msg: "Changing...",
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white);

                                      try {
                                        await UserController
                                            .changeCurrentUserPassword(
                                          oldPassword:
                                              alertPasswordController.text,
                                          newPassword:
                                              alertNewPasswordController.text,
                                        );
                                        alertNewPasswordController.clear();
                                        alertPasswordController.clear();
                                        alertConfirmPasswordController.clear();
                                        Fluttertoast.showToast(
                                            msg:
                                                "Password changed successfully");
                                        Navigator.pop(context);
                                      } catch (e) {
                                        Fluttertoast.showToast(
                                          msg: e.message,
                                          backgroundColor: Colors.black,
                                          textColor: Colors.white,
                                        );
                                      }
                                    }
                                  },
                                  heading: "Change Password",
                                  buttonText: "Change it",
                                );
                              },
                              dense: true,
                              title: Text(
                                ('Change Password'),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context).accentColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                      NeumorphicCard(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  college.name,
                                  style: NeumorphicTheme.currentTheme(context)
                                      .textTheme
                                      .headline3,
                                ),
                                NeumorphicButton(
                                  onPressed: () async {
                                    await UserController.updateCollege(
                                      userId: user.userId,
                                      collegeId: _selectedCollege.cid,
                                    );
                                    user.collegeId = _selectedCollege.cid;
                                    user.updateUserInProvider(user);
                                    _currentCollege.updateCollegeInProvider(
                                        _selectedCollege);
                                  },
                                  child: Icon(Icons.check),
                                ),
                              ],
                            ),
                            Form(
                              child: FutureBuilder(
                                future: _future,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return CollegeDropdown(
                                      dropDownItems: _dropDownItems,
                                      hintText: "Change your college",
                                      onChanged: (College clg) {
                                        setState(() {
                                          _selectedCollege = clg;
                                        });
                                      },
                                    );
                                  } else
                                    return NeumorphicProgressIndeterminate();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      NeumorphicCard(
                        child: RaisedButton.icon(
                          elevation: 0,
                          padding: EdgeInsets.all(10),
                          color:
                              NeumorphicTheme.currentTheme(context).baseColor,
                          onPressed: () {
                            Navigator.pushNamed(
                                context, MyTransactionsHistory.id);
                          },
                          icon: Icon(Icons.attach_money),
                          label: Text('My Transactions History'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  showAlert(
      {BuildContext context,
      Widget content,
      String heading,
      String buttonText,
      VoidCallback onPressed}) {
    Alert(
      context: context,
      buttons: [
        DialogButton(
          child: Text(
            buttonText,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: onPressed,
          color: NeumorphicTheme.currentTheme(context).accentColor,
          radius: BorderRadius.circular(20.0),
        ),
      ],
      title: heading,
      content: content,
      style: kAlertStyle,
    ).show();
  }
}
