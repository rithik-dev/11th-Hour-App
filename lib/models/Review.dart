import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Review {
  String userId;
  String text;
  Timestamp time;
  int rating;

  Review({
    @required this.userId,
    @required this.text,
    @required this.time,
    @required this.rating,
  });
}
