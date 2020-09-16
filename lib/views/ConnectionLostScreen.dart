import 'package:eleventh_hour/components/ConnectionLostClipper.dart';
import 'package:eleventh_hour/models/DeviceDimension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

class ConnectionLost extends StatelessWidget {
  static const String id = '/connection';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            transform: Matrix4.translationValues(0.0, -50.0, 0.0),
            child: ClipShadowPath(
                clipper: CircularClipper(),
                shadow: Shadow(blurRadius: 20.0),
                child: Image(
                  width: Provider.of<DeviceDimension>(context).width,
                  image: AssetImage('assets/images/connection_lost.png'),
                )),
          ),
          Text(
            "Connection Lost",
            style: NeumorphicTheme.currentTheme(context)
                .textTheme
                .headline3
                .copyWith(fontFamily: "pacifico"),
            textAlign: TextAlign.center,
          ),
          Container(
            margin: EdgeInsets.all(30),
            decoration: ShapeDecoration(
                color: Colors.grey[300],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)))),
            padding: EdgeInsets.all(10),
            child: Text(
              "Hey,\nIt looks like you are not connected to internet.\n\n Try Again Later!!!",
              style: NeumorphicTheme.currentTheme(context).textTheme.headline1,
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
