import 'package:eleventh_hour/components/TransactionCard.dart';
import 'package:eleventh_hour/controllers/TransactionController.dart';
import 'package:eleventh_hour/models/Transaction.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MyTransactionsHistory extends StatelessWidget {
  static const id = 'transaction_history';

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Scaffold(
      appBar: NeumorphicAppBar(
        title: NeumorphicText(
          "Transactions History ",
          style: NeumorphicStyle(color: Colors.black),
          textStyle: NeumorphicTextStyle(fontSize: 20),
        ),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: TransactionController.getTransactionsById(user.transactionIds),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data[index].courseIds.toString()),
                );
              },
              itemCount: snapshot.data.length,
            );
          } else {
            return Shimmer.fromColors(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    child: TransactionCard(isShimmer: true),
                  );
                },
                itemCount: user.transactionIds.length,
              ),
              baseColor: Colors.grey[800],
              highlightColor: Colors.white,
            );
          }
        },
      ),
    );
  }
}
