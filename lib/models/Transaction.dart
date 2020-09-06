import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Transaction {
  Timestamp date;
  String status;
  String transactionId;
  String docId;
  String courseName;
  double amount;

  Transaction({
    @required this.date,
    @required this.courseName,
    @required this.status,
    @required this.transactionId,
    @required this.amount,
    this.docId,
  });

  factory Transaction.fromDocumentSnapshot(DocumentSnapshot transaction) {
    return new Transaction(
        courseName: transaction['courseName'] as String,
        date: transaction['date'] as Timestamp,
        status: transaction['status'] as String,
        transactionId: transaction['transactionId'] as String,
        amount: transaction['amount'] as double,
        docId: transaction['docId'] as String);
  }

  Map<String, dynamic> toMap() {
    return {
      "date": this.date,
      "courseName": this.courseName,
      "status": this.status,
      "transactionId": this.transactionId,
      "amount": this.amount,
    };
  }
}
