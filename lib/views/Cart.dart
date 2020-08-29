import 'package:eleventh_hour/components/404Card.dart';
import 'package:eleventh_hour/controllers/UserController.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const id = '/cart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<User>(builder: (context, user, child) {
          return RefreshIndicator(
            onRefresh: () async {
              final User newUser = await UserController.getUser(user.userId);
              Provider.of<User>(context, listen: false)
                  .updateUserInProvider(newUser);
            },
            child: (user.cart == null || user.cart.length == 0)
                ? Card404(title: "CART")
                : Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: ListView(
                            children: [Text("COurses")],
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        }),
      ),
    );
  }
}
