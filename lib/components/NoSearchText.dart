import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoSearchText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: [
          Lottie.asset('assets/lottie/no-search-text.json'),
          Text(
            "\n\nSearch for new courses",
            style: Theme.of(context).textTheme.headline1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
