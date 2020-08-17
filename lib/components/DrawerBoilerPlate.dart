import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';

import 'DrawerContent.dart';

class CustomDrawer extends StatelessWidget {
  final Widget scaffold;
  final GlobalKey<InnerDrawerState> innerDrawerKey;

  CustomDrawer({this.scaffold, this.innerDrawerKey});
  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
      key: innerDrawerKey,
      proportionalChildArea: true, // default true
      borderRadius: 50, // default 0
      boxShadow: [
        BoxShadow(spreadRadius: 10, blurRadius: 3, color: Colors.transparent)
      ],
      leftAnimationType: InnerDrawerAnimation.linear,
      onTapClose: true,
      backgroundDecoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Theme.of(context).accentColor,
            Theme.of(context).primaryColor
          ])),
      colorTransitionScaffold: Theme.of(context).primaryColor,
      leftChild: DrawerContent(),
      scale: IDOffset.horizontal(0.8),
      scaffold: scaffold,
    );
  }
}
