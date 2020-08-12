import 'package:eleventh_hour/components/CustomTextFormField.dart';
import 'package:eleventh_hour/controllers/UserController.dart';
import 'package:eleventh_hour/views/RegistrationScreen.dart';
import 'package:flutter/material.dart';
import 'package:eleventh_hour/models/Exceptions.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  static const id = '/login';

  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LOGIN"),
        centerTitle: true,
        leading: Container(),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CustomTextFormField(
              labelText: "Email",
              icon: Icons.mail,
              autofocus: true,
              onChanged: (String value) {
                _email = value;
              },
              validator: (String value) {
                if (value.isEmpty || value.trim() == "") {
                  return 'Please Enter Your Email';
                }
                return null;
              },
            ),
            SizedBox(height: 10.0),
            CustomTextFormField(
              labelText: "Password",
              icon: Icons.lock,
              onChanged: (String value) {
                _password = value;
              },
              validator: (String value) {
                if (value.isEmpty || value.trim() == "") {
                  return 'Please Enter Your Password';
                }
                return null;
              },
            ),
            Builder(
              builder: (context) {
                return FlatButton(
                  child: Text("LOGIN"),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      String msg;
                      try {
                        final bool loginSuccessful =
                            await UserController.loginUser(
                          _email.trim(),
                          _password,
                        );
                        if (loginSuccessful)
                          // TODO: navigate to app screen
                          print("LOGIN USER");
                        else
                          msg =
                              "Error While Logging In . Please try again after some time.";
                      } on LoginException catch (e) {
                        if (e.message != null) msg = e.message;
                      } catch (e) {
                        msg = e.message;
                      }

                      if (msg == "EMAIL_NOT_VERIFIED")
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please Verify Your Email"),
                            action: SnackBarAction(
                              label: "RESEND LINK !",
                              onPressed: () async {
                                final bool success = await UserController
                                    .resendEmailVerificationLink(
                                        _email, _password);
                                if (success)
                                  msg =
                                      "Email Verification Link Sent Successfully !";
                                else
                                  msg =
                                      "An Error Occurred While Sending Email Verification Link !";

                                if (msg != null)
                                  Fluttertoast.showToast(msg: msg);
                              },
                            ),
                          ),
                        );
                      else {
                        if (msg != null) Fluttertoast.showToast(msg: msg);
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
                    final bool success =
                        await UserController.sendPasswordResetEmail(_email);
                    if (success)
                      msg = "Password Reset Email Sent !";
                    else
                      msg = "Error While Sending Password Reset Email !";
                  } on ForgotPasswordException catch (e) {
                    msg = e.message;
                  } catch (e) {
                    msg = e.message;
                  }
                } else
                  msg = "Please Enter Your Email !";

                Fluttertoast.showToast(msg: msg);
              },
            ),
            FlatButton(
              child: Text("Register ?"),
              onPressed: () {
                Navigator.pushReplacementNamed(context, RegistrationScreen.id);
              },
            )
          ],
        ),
      ),
    );
  }
}
