import 'package:flutter/cupertino.dart';

class Transaction {
  DateTime date;
  String status;
  String transactionId;
  String id;
  double amount;

  Transaction({
    @required this.date,
    @required this.status,
    @required this.transactionId,
    @required this.amount,
    @required this.id,
  });
}
