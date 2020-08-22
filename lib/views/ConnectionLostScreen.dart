import 'package:eleventh_hour/components/ConnectionLostClipper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                  width: MediaQuery.of(context).size.width,
                  image: AssetImage('assets/images/connection_lost.png'),
                )),
          ),
          Text(
            "Connection Lost",
            style: Theme.of(context)
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
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Colors.black,
                  ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
