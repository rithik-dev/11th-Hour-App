import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

AlertStyle kAlertStyle = AlertStyle(
  animationType: AnimationType.grow,
  isCloseButton: true,
  isOverlayTapDismiss: true,
  descStyle: TextStyle(fontWeight: FontWeight.w300),
  animationDuration: Duration(milliseconds: 400),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20.0),
    side: BorderSide(
      color: Colors.grey,
    ),
  ),
  titleStyle: TextStyle(
    color: Colors.black,
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(22.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(22.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(22.0)),
  ),
);

//var kDefaultTheme = ThemeData.dark();

const kDefaultProfilePicUrl =
    "https://firebasestorage.googleapis.com/v0/b/eleventhhour-eb2e0.appspot.com/o/userDefault.jpeg?alt=media&token=ac1366cc-f928-4a08-8bee-1dfd5788db68";

const kButtonTextStyle =
    TextStyle(fontFamily: 'karla', fontSize: 25, fontWeight: FontWeight.bold);
const bodyStyle = TextStyle(fontSize: 19.0, color: Colors.black);
const pageDecoration = const PageDecoration(
  titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
  bodyTextStyle: bodyStyle,
  descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
  pageColor: Colors.pink,
  imagePadding: EdgeInsets.zero,
);
var kDefaultTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: Color(0xFF1a1a2e),
  accentColor: Color(0xFFe94560),
  textTheme: TextTheme(
    button: TextStyle(color: Color(0xFF252525)),
    headline5:
        TextStyle(fontSize: 20.0, color: Colors.black, fontFamily: 'karla'),
    headline4: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.grey,
        fontFamily: 'karla'),
    headline3: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: Colors.grey,
        fontFamily: 'karla'),
    headline2: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.w700,
        color: Colors.grey,
        fontFamily: 'karla'),
    headline1: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.w300,
        color: Colors.grey,
        fontFamily: 'karla'),
    subtitle1: TextStyle(
        fontSize: 14.5,
        fontWeight: FontWeight.w500,
        color: Colors.white,
        fontFamily: 'karla'),
    headline6: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        fontFamily: 'karla'),
    bodyText2:
        TextStyle(fontSize: 12.0, color: Colors.white, fontFamily: 'karla'),
    bodyText1: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        fontFamily: 'karla'),
    caption:
        TextStyle(fontSize: 12.0, color: Colors.white, fontFamily: 'karla'),
  ),
  primaryColor: Color(0xFF1a1a2e),
);
//brightness: Brightness.light,
//accentColor: Colors.green,
//focusColor: Colors.purpleAccent,
//inputDecorationTheme: InputDecorationTheme(
//focusedBorder: OutlineInputBorder(
//borderSide: BorderSide(
//color: Colors.pink,
//style: BorderStyle.solid,
//width: 2,
//)),
////          labelText: "Product Name",
//labelStyle: TextStyle(
//color: Colors.purple,
//),
//hintStyle: TextStyle(
//color: Colors.grey[600],
//),
////          hintText: "Enter your product name",
//
//// hintColor: Colors.blue,
//border: OutlineInputBorder(
//borderRadius: BorderRadius.all(Radius.circular(20.0)),
//),
//),
//hintColor: Colors.pink,
//const kTextFieldDecoration = InputDecoration(
//  prefixIcon: Icon(
//    Icons.person,
//    color: Colors.black,
//  ),
//  focusedBorder: OutlineInputBorder(
//      borderSide: BorderSide(
//    color: Colors.black38,
//    style: BorderStyle.solid,
//    width: 2,
//  )),
//  labelText: "Enter Value",
//  labelStyle: TextStyle(color: Colors.black, fontFamily: 'karla'),
//  hintStyle: TextStyle(color: Colors.grey, fontFamily: 'karla'),
//  hintText: "Enter",
//
//// hintColor: Colors.blue,
//  border: OutlineInputBorder(
//    borderRadius: BorderRadius.all(Radius.circular(20.0)),
//  ),
//);
