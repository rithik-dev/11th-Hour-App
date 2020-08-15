import 'dart:io';

import 'package:eleventh_hour/components/CustomTextFormField.dart';
import 'package:eleventh_hour/controllers/UserController.dart';
import 'package:eleventh_hour/models/College.dart';
import 'package:eleventh_hour/models/Exceptions.dart';
import 'package:eleventh_hour/views/LoginScreen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

final FirebaseStorage _storage =
    FirebaseStorage(storageBucket: 'gs://eleventhhour-eb2e0.appspot.com');

class RegistrationScreen extends StatefulWidget {
  static const id = '/register';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  String _email;

  String _password;

  String _fullName;

  String _phone;

  College _college;

  String uploadFileUrl;
  final picker = ImagePicker();
  File _image;
  bool imageSelected = false;
  bool isLoading = false;
  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    setState(() {
      imageSelected = true;
      _image = File(pickedFile.path);
    });
  }

  Future uploadFile() async {
    print("here");
    String filePath = DateTime.now().toString();
    StorageUploadTask uploadTask =
        _storage.ref().child('images/$filePath.png').putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    String fileURL =
        await _storage.ref().child('images/$filePath.png').getDownloadURL();
    setState(() {
      uploadFileUrl = fileURL;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REGISTER"),
        centerTitle: true,
        leading: Container(),
      ),
      body: ListView(children: [
        Container(
          padding: EdgeInsets.all(18),
          margin: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                backgroundImage: imageSelected
                    ? FileImage(_image)
                    : AssetImage('assets/images/userDefault.jpeg'),
                radius: 55,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.camera),
                        onPressed: () {
                          getImage(ImageSource.camera);
                        },
                      ),
                      SizedBox(
                        child: Divider(
                          color: Colors.black54,
                          thickness: 30,
                        ),
                        height: 30,
                        width: 5,
                      ),
                      IconButton(
                          icon: Icon(Icons.image),
                          onPressed: () {
                            getImage(ImageSource.gallery);
                          })
                    ],
                  ),
                  Text(
                    "Choose a pic/ \n Go Professor",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Form(
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
                labelText: "Phone",
                icon: FontAwesomeIcons.phone,
                onChanged: (String value) {
                  _phone = value;
                },
                validator: (String value) {
                  if (value.isEmpty || value.trim() == "") {
                    return 'Please Enter your phone';
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
                        Fluttertoast.showToast(msg: "Loading..");
                        try {
                          await uploadFile();
                          final bool registerSuccessful =
                              await UserController.registerUser(
                                  email: _email.trim(),
                                  collegeId: "laeda",
//                                _college.cid,
                                  profileURL: imageSelected == true
                                      ? uploadFileUrl
                                      : "https://firebasestorage.googleapis.com/v0/b/eleventhhour-eb2e0.appspot.com/o/userDefault.jpeg?alt=media&token=ac1366cc-f928-4a08-8bee-1dfd5788db68",
                                  phone: _phone,
                                  password: _password,
                                  name: _fullName);
                          if (registerSuccessful) {
                            msg = "Verification Email Sent Successfully !";
                          } else {
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
      ]),
    );
  }
}
