import 'package:cloud_firestore/cloud_firestore.dart' as Fire;
import 'package:eleventh_hour/models/Transaction.dart';

class TransactionController {
  static final Fire.Firestore _fireStore = Fire.Firestore.instance;

  static Future getTransactionsById() async {
    List<Transaction> transactions = [];
    var transactionQuery =
        await _fireStore.collection('transactions').getDocuments();
    transactionQuery.documents.forEach((element) {
      transactions.add((Transaction.fromDocumentSnapshot(element)));
    });
  }

  static Future addTransactionToUser(
      {Transaction transaction, String userId}) async {
    Fire.DocumentReference docId =
        await _fireStore.collection('transactions').add(transaction.toMap());
    await _fireStore.collection('users').document(userId).updateData({
      "transactionIds": Fire.FieldValue.arrayUnion([docId.documentID])
    });
  }
}
