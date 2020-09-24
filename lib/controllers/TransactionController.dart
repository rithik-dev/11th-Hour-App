import 'package:cloud_firestore/cloud_firestore.dart' as Fire;
import 'package:eleventh_hour/models/Transaction.dart';

class TransactionController {
  static final Fire.Firestore _fireStore = Fire.Firestore.instance;

  static Future<List<Transaction>> getTransactionsById(
      List transactionIds) async {
    List<Transaction> transactions = [];
    var transactionQuery = await _fireStore
        .collection('transactions')
        .orderBy('date', descending: true)
        .getDocuments();

    for (Fire.DocumentSnapshot transaction in transactionQuery.documents) {
      if (transactionIds.contains(transaction.documentID)) {
        transactions.add(Transaction.fromDocumentSnapshot(transaction));
      }
    }
    return transactions;
  }

  static Future<String> addTransactionToUser(
      {Transaction transaction, String userId}) async {
    Fire.DocumentReference docRef =
        await _fireStore.collection('transactions').add(transaction.toMap());
    await _fireStore.collection('users').document(userId).updateData({
      "transactionIds": Fire.FieldValue.arrayUnion([docRef.documentID])
    });
    return docRef.documentID;
  }
}
