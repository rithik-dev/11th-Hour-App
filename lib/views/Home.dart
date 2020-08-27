import 'package:eleventh_hour/components/SlimyBottom.dart';
import 'package:eleventh_hour/components/SlimyTop.dart';
import 'package:eleventh_hour/models/College.dart';
import 'package:eleventh_hour/models/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slimy_card/slimy_card.dart';

class Home extends StatefulWidget {
  static const id = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<User, College>(
        builder: (context, user, college, child) {
          return ListView(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            children: [
              Text(
                "${college.name}'s Subjects",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline2,
              ),
              SizedBox(
                height: 20,
              ),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 30,
                children: [
                  Chip(
                    label: Text("CS"),
                  ),
                  Chip(
                    label: Text("MEC"),
                  ),
                  Chip(
                    label: Text("BBA"),
                  ),
                  Chip(
                    label: Text("LAW"),
                  ),
                ],
              ),
//              ListView.builder(
//                shrinkWrap: true,
//                scrollDirection: Axis.horizontal,
//                itemCount: 5,
//                itemBuilder: (context, index) {
//                  return Padding(
//                    padding:
//                    EdgeInsets.symmetric(vertical: 0, horizontal: 20),
//                    child: SlimyCard(
//                      color:
//                      index % 2 == 0 ? Colors.purple : Colors.grey[700],
//                      width: 200,
//                      topCardHeight: 150,
//                      bottomCardHeight: 100,
//                      borderRadius: 15,
//                      topCardWidget: SlimyTop(),
//                      bottomCardWidget: SlimyBottom(),
//                      slimeEnabled: true,
//                    ),
//                  );
//                },
//              ),
              Text(
                "Trending",
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 325,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      child: SlimyCard(
                        color:
                            index % 2 == 0 ? Colors.purple : Colors.grey[700],
                        width: 200,
                        topCardHeight: 150,
                        bottomCardHeight: 100,
                        borderRadius: 15,
                        topCardWidget: SlimyTop(),
                        bottomCardWidget: SlimyBottom(),
                        slimeEnabled: true,
                      ),
                    );
                  },
                ),
              ),
              Text(
                "Continue Watching",
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 325,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      child: SlimyCard(
                        color:
                            index % 2 == 0 ? Colors.purple : Colors.grey[700],
                        width: 200,
                        topCardHeight: 150,
                        bottomCardHeight: 100,
                        borderRadius: 15,
                        topCardWidget: SlimyTop(),
                        bottomCardWidget: SlimyBottom(),
                        slimeEnabled: true,
                      ),
                    );
                  },
                ),
              ),
//              ListView.builder(
//                scrollDirection: Axis.horizontal,
//                itemCount: 0,
//                itemBuilder: (context, index) {
//                  return;
//                },
//              ),
//              ListView.builder(
//                scrollDirection: Axis.horizontal,
//                itemCount: 0,
//                itemBuilder: (context, index) {
//                  return;
//                },
//              )
            ],
          );
        },
      ),
    );
  }
}
