import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  static const id = '/cart';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("My Cart"),
      ),
      body: Center(child: Text("Cart")),
    );
  }
}
