import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eleventh_hour/components/404Card.dart';
import 'package:eleventh_hour/components/SmallCourseCard.dart';
import 'package:eleventh_hour/controllers/CourseController.dart';
import 'package:eleventh_hour/controllers/TransactionController.dart';
import 'package:eleventh_hour/controllers/UserController.dart';
import 'package:eleventh_hour/models/Course.dart';
import 'package:eleventh_hour/models/Transaction.dart' as T;
import 'package:eleventh_hour/models/User.dart';
import 'package:eleventh_hour/utilities/UiIcons.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CartScreen extends StatefulWidget {
  static const id = '/cart';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String courseNames = "";

  void handlerPaymentSuccess(PaymentSuccessResponse response) async {
    print(courseNames);
    print("Payment success");
    print(response.paymentId);
    await UserController.handlePaymentSuccess(
      userId: Provider.of<User>(context, listen: false).userId,
      courseIds: Provider.of<User>(context, listen: false).cart.cast<String>(),
    );

    await TransactionController.addTransactionToUser(
      transaction: T.Transaction(
          courseNames: courseNames,
          amount: amount.toDouble(),
          transactionId: response.paymentId,
          status: "Success",
          date: Timestamp.now()),
      userId: Provider.of<User>(context, listen: false).userId,
    );
    Provider.of<CourseController>(context, listen: false).addUserToCourses(
      userId: Provider.of<User>(context, listen: false).userId,
      courseIds: Provider.of<User>(context, listen: false).cart.cast<String>(),
    );
    Provider.of<User>(context, listen: false).handleCheckoutSuccess();
    Fluttertoast.showToast(msg: "Payment Success");
  }

  int amount = 0;

  @override
  void dispose() {
    super.dispose();
    razorPay.clear();
  }

//  static const platform = const MethodChannel("razorpay_flutter");
  void handlerErrorFailure(PaymentFailureResponse response) async {
    await TransactionController.addTransactionToUser(
      transaction: T.Transaction(
          courseNames: courseNames,
          amount: amount.toDouble(),
          transactionId: response.code.toString(),
          status: "Failure",
          date: Timestamp.now()),
      userId: Provider.of<User>(context, listen: false).userId,
    );
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

  void openCheckout(String phone, String email) {
    var options = {
      "key": "rzp_test_NwfgCE8CdhXpFT",
      "amount": amount * 100,
      "name": "11th Hour",
      "description": "Start Learning!!!",
      "prefill": {"contact": phone, "email": email},
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

  void _calculateAmountAndNames(List<Course> courses) {
    amount = 0;
    courseNames = "";
    for (Course course in courses) {
      if (!course.blackListed) {
        courseNames += "${course.title} ";
        amount += course.price;
      }
    }
    print(courseNames);
  }

  List<Course> _courses;

  @override
  Widget build(BuildContext context) {
    return Consumer2<User, CourseController>(
      builder: (context, user, courses, child) {
        if (user.cart == null)
          _courses = [];
        else
          _courses = courses.getCoursesByIds(user.cart.cast<String>());

        _calculateAmountAndNames(_courses);

        return Scaffold(
            bottomNavigationBar: Container(
              padding: EdgeInsets.all(20),
              color: Theme.of(context).primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rs.$amount",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  RaisedButton.icon(
                      onPressed: amount == 0
                          ? null
                          : () {
                              openCheckout(user.phone, user.email);
                            },
                      disabledColor: Colors.white30,
                      icon: Icon(UiIcons.money),
                      label: Text("Proceed to pay"))
                ],
              ),
            ),
            appBar: AppBar(
              title: Text("My Cart"),
              centerTitle: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 0,
              automaticallyImplyLeading: true,
            ),
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  final User newUser =
                      await UserController.getUser(user.userId);
                  Provider.of<User>(context, listen: false)
                      .updateUserInProvider(newUser);
                  await Provider.of<CourseController>(context, listen: false)
                      .getCourses();
                },
                child: (user.cart == null || user.cart.length == 0)
                    ? Card404(title: "CART")
                    : ListView(
                        children: _courses
                            .map((course) => SmallCourseCard(
                                  course: course,
                                ))
                            .toList(),
                      ),
              ),
            ));
      },
    );
  }
}
