import 'package:eleventh_hour/components/404Card.dart';
import 'package:eleventh_hour/controllers/UserController.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CartScreen extends StatefulWidget {
  static const id = '/cart';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void handlerPaymentSuccess(PaymentSuccessResponse response) {
    print("Payment success");
    Fluttertoast.showToast(msg: "Payment Success");
  }

  @override
  void dispose() {
    super.dispose();
    razorPay.clear();
  }

  static const platform = const MethodChannel("razorpay_flutter");
  void handlerErrorFailure(PaymentFailureResponse response) {
    print("Payment error");
    Fluttertoast.showToast(msg: "Payment Error");
  }

  void handlerExternalWallet(ExternalWalletResponse response) {
    print("External Wallet");
    Fluttertoast.showToast(msg: "External");
  }

  Razorpay razorPay;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    razorPay = new Razorpay();

    razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_NwfgCE8CdhXpFT",
      "amount": num.parse("200") * 100,
      "name": "11th Hour",
      "description": "Start Learning!!!",
      "prefill": {
        "contact": "9953798220",
        "email": "shivamthegreat.sv@gmail.com"
      },
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      razorPay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

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
            child: !(user.cart == null || user.cart.length == 0)
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
                      FlatButton(
                        child: Text("lol"),
                        onPressed: () {
                          openCheckout();
                        },
                      )
                    ],
                  ),
          );
        }),
      ),
    );
  }
}
