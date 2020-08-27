import 'package:flutter/material.dart';

class SlimyTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "Top",
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }
}
