import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoSearchResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: [
          Lottie.asset('assets/lottie/no-search-results.json'),
        ],
      ),
    );
  }
}
