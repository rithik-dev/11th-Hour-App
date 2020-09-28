import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eleventh_hour/components/CustomTextFormField.dart';
import 'package:eleventh_hour/components/HomeBoilerPlate.dart';
import 'package:eleventh_hour/components/LoadingScreen.dart';
import 'package:eleventh_hour/controllers/CourseController.dart';
import 'package:eleventh_hour/controllers/UserController.dart';
import 'package:eleventh_hour/models/College.dart';
import 'package:eleventh_hour/models/DeviceDimension.dart';
import 'package:eleventh_hour/models/Exceptions.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:eleventh_hour/views/RegistrationScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  static const id = '/login';
  final String password, email;

  LoginScreen({this.password = "", this.email = ""});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  String _email;
  bool isLoading = false;
  String _password;

  DeviceDimension device = DeviceDimension(height: 0, width: 0);

  Future<void> whenNotZero() async {
    Stream<double> source = Stream<double>.periodic(
      Duration(milliseconds: 50),
      (x) => MediaQuery.of(context).size.width,
    );

    await for (double value in source) {
      if (value > 0) {
        setState(() {
          device = DeviceDimension(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          );
        });
        return;
      }
    }
    // stream exited without a true value, maybe return an exception.
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _email = widget.email;
    _password = widget.password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/bg2.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      "Login\n\n",
                      textAlign: TextAlign.center,
                      style: NeumorphicTheme.currentTheme(context)
                          .textTheme
                          .headline1,
                    ),
                    CustomTextFormField(
                      labelText: "Email",
                      defaultValue: widget.email,
                      icon: Icons.mail,
                      autofocus: true,
                      onChanged: (String value) {
                        _email = value;
                      },
                      validator: (String value) {
                        if (value.isEmpty || value.trim() == "")
                          return 'Please Enter Your Email';
                        else if (!(value.contains("@") && value.contains(".")))
                          return "Invalid Email";
                        return null;
                      },
                    ),
                    SizedBox(height: 10.0),
                    CustomTextFormField(
                      defaultValue: widget.password,
                      labelText: "Password",
                      icon: Icons.lock,
                      onChanged: (String value) {
                        _password = value;
                      },
                      validator: (String value) {
                        if (value.isEmpty || value.trim() == "")
                          return 'Please Enter Your Password';
                        else if (value.length < 6)
                          return "Length should be greater than 5";
                        return null;
                      },
                    ),
                    Builder(
                      builder: (context) {
                        return FlatButton(
                          child: Text("LOGIN"),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              String msg;
                              try {
                                final String userId =
                                    await UserController.loginUser(
                                  email: _email.trim(),
                                  password: _password,
                                );
                                if (userId != null) {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setString('userId', userId);

                                  final DocumentSnapshot snapshot =
                                      await Firestore.instance
                                          .collection("users")
                                          .document(userId)
                                          .get();

                                  final collegeSnapshot = await Firestore
                                      .instance
                                      .collection("colleges")
                                      .document(snapshot['collegeId'])
                                      .get();

                                  final User user =
                                      User.fromDocumentSnapshot(snapshot);
                                  final College college =
                                      College.fromDocumentSnapshot(
                                          collegeSnapshot);
                                  Provider.of<User>(context, listen: false)
                                      .updateUserInProvider(user);
                                  Provider.of<College>(context, listen: false)
                                      .updateCollegeInProvider(college);
                                  await Provider.of<CourseController>(context,
                                          listen: false)
                                      .getCourses();
                                  await whenNotZero();
                                  Provider.of<DeviceDimension>(context,
                                          listen: false)
                                      .updateDeviceInProvider(device: device);
                                  Navigator.pushReplacementNamed(
                                      context, HomeBoilerPlate.id);
                                } else
                                  msg =
                                      "Error While Logging In . Please try again after some time.";
                              } on LoginException catch (e) {
                                if (e.message != null) msg = e.message;
                              } catch (e) {
                                msg = e.toString();
                              } finally {
                                setState(() {
                                  isLoading = false;
                                });
                              }

                              if (msg == "EMAIL_NOT_VERIFIED")
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Please Verify Your Email"),
                                    action: SnackBarAction(
                                      label: "RESEND LINK !",
                                      onPressed: () async {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        final bool success =
                                            await UserController
                                                .resendEmailVerificationLink(
                                                    _email.trim(), _password);
                                        if (success)
                                          msg =
                                              "Email Verification Link Sent Successfully !";
                                        else
                                          msg =
                                              "An Error Occurred While Sending Email Verification Link !";
                                        setState(() {
                                          isLoading = false;
                                        });
                                        if (msg != null)
                                          Fluttertoast.showToast(msg: msg);
                                      },
                                    ),
                                  ),
                                );
                              else {
                                if (msg != null)
                                  Fluttertoast.showToast(msg: msg);
                              }
                            }
                          },
                        );
                      },
                    ),
                    FlatButton(
                      child: Text("FORGOT PASSWORD ?"),
                      onPressed: () async {
                        String msg;
                        if (_email != null && _email.trim() != "") {
                          try {
                            setState(() {
                              isLoading = true;
                            });
                            final bool success =
                                await UserController.sendPasswordResetEmail(
                                    _email);
                            if (success)
                              msg = "Password Reset Email Sent !";
                            else
                              msg =
                                  "Error While Sending Password Reset Email !";
                          } on ForgotPasswordException catch (e) {
                            msg = e.message;
                          } catch (e) {
                            msg = e.toString();
                          } finally {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        } else
                          msg = "Please Enter Your Email !";

                        Fluttertoast.showToast(msg: msg);
                      },
                    ),
                    FlatButton(
                      child: Text("Register ?"),
                      onPressed: () {
                        Navigator.popAndPushNamed(
                            context, RegistrationScreen.id);
                      },
                    )
                  ],
                ),
              ),
              isLoading ? LoadingScreen() : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
