import 'package:eleventh_hour/components/404Card.dart';
import 'package:eleventh_hour/components/HomeBoilerPlate.dart';
import 'package:eleventh_hour/components/TransactionCard.dart';
import 'package:eleventh_hour/controllers/TransactionController.dart';
import 'package:eleventh_hour/models/Transaction.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:eleventh_hour/utilities/UiIcons.dart';
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
        actions: [
          NeumorphicButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeBoilerPlate.id, (route) => false);
            },
            child: Icon(UiIcons.home),
          )
        ],
        title: NeumorphicText(
          "Transactions History ",
          style: NeumorphicStyle(color: Colors.black),
          textStyle: NeumorphicTextStyle(fontSize: 20),
        ),
      ),
      body: user.transactionIds.length == 0
          ? Card404(
              desc: "You don't have any course.",
            )
          : FutureBuilder<List<Transaction>>(
              future: TransactionController.getTransactionsById(
                  user.transactionIds),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return TransactionCard(transaction: snapshot.data[index]);
                    },
                    itemCount: snapshot.data.length,
                  );
                } else {
                  return Shimmer.fromColors(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Container(
                          height: 100,
                          width: 300,
                          margin: EdgeInsets.all(10),
                          color: Colors.white,
                        );
                      },
                      itemCount: user.transactionIds.length,
                    ),
                    baseColor: Colors.white,
                    highlightColor: Colors.grey[400],
                  );
                }
              },
            ),
    );
  }
}
