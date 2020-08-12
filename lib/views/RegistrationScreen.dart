import 'package:eleventh_hour/components/CustomTextFormField.dart';
import 'package:eleventh_hour/models/Exceptions.dart';
import 'package:eleventh_hour/controllers/UserController.dart';
import 'package:eleventh_hour/views/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class RegistrationScreen extends StatelessWidget {
  static const id = '/register';

  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  String _fullName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REGISTER"),
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
              labelText: "Full Name",
              icon: Icons.text_fields,
              autofocus: true,
              onChanged: (String value) {
                _fullName = value;
              },
              validator: (String value) {
                if (value.isEmpty || value.trim() == "") {
                  return 'Please Enter Your Full Name';
                }
                return null;
              },
            ),
            SizedBox(height: 10.0),
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
                  child: Text("REGISTER"),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      String msg;

                      try {
                        final bool registerSuccessful =
                            await UserController.registerUser(
                          _email.trim(),
                          _password,
                          fullName: _fullName.trim(),
                        );
                        if (registerSuccessful)
                          msg = "Verification Email Sent Successfully !";
                        else {
                          msg = "Error While Registering New User";
                        }
                      } on RegistrationException catch (e) {
                        if (e.message != null) msg = e.message;
                      } catch (e) {
                        msg = e.message;
                      }
                      Fluttertoast.showToast(msg: msg);
                    }
                  },
                );
              },
            ),
            FlatButton(
              child: Text("Login ?"),
              onPressed: () {
                Navigator.pushReplacementNamed(context, LoginScreen.id);
              },
            )
          ],
        ),
      ),
    );
  }
}
