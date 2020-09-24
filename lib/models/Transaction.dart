import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Transaction {
  Timestamp date;
  String status;
  String transactionId;
  String id;
  List courseIds;
  double amount;

  Transaction({
    @required this.date,
    @required this.courseIds,
    @required this.status,
    @required this.transactionId,
    @required this.amount,
    this.id,
  });

  factory Transaction.fromDocumentSnapshot(DocumentSnapshot transaction) {
    return new Transaction(
      courseIds: transaction['courseNames'] as List<dynamic>,
      date: transaction['date'] as Timestamp,
      status: transaction['status'] as String,
      transactionId: transaction['transactionId'] as String,
      amount: transaction['amount'] as double,
      id: transaction.documentID,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "date": this.date,
      "courseNames": this.courseIds,
      "status": this.status,
      "transactionId": this.transactionId,
      "amount": this.amount,
    };
  }

  @override
  String toString() {
    return 'Transaction{date: $date, status: $status, transactionId: $transactionId, docId: $id, courseNames: $courseIds, amount: $amount}';
  }
}
