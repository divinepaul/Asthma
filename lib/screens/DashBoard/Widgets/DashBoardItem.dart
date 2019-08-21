

import 'package:asthma/screens/RecordPage/RecordPage.dart';
import 'package:asthma/screens/StatsPage/StatsPage.dart';
import 'package:flutter/material.dart';


class DashBoardItem extends StatelessWidget {
  final double height;
  final double width;
  final String text;
  final String asset;
  final bool orderReverse;

  const DashBoardItem(
      {Key key,
      @required this.height,
      @required this.width,
      @required this.text,
      @required this.asset,
      @required this.orderReverse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return orderReverse
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Image.asset(
                asset,
                height: height / 4,
                width: width / 1.9,
              ),
              Material(
                color: Color(0xff0000ff),
                elevation: 30,
                borderRadius: BorderRadius.circular(23),
                child: InkWell(
                  borderRadius: BorderRadius.circular(23),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StatisticsPage()),
                    );
                  },
                  child: Container(
                    height: height / 4,
                    width: width / 2.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(23))),
                    child: Padding(
                      padding: EdgeInsets.all(width / 20),
                      child: Center(
                          child: Text(
                        text,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: width / 15,
                            fontWeight: FontWeight.w900),
                      )),
                    ),
                  ),
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Material(
                elevation: 30,
                borderRadius: BorderRadius.circular(23),
                color: Color(0xff0000ff),
                child: InkWell(
                  borderRadius: BorderRadius.circular(23),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RecordPage()),
                    );
                  },
                  child: Container(
                    height: height / 4,
                    width: width / 2.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(23))),
                    child: Padding(
                      padding: EdgeInsets.all(width / 20),
                      child: Center(
                          child: Text(
                        text,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: width / 15,
                            fontWeight: FontWeight.w900),
                      )),
                    ),
                  ),
                ),
              ),
              Image.asset(
                asset,
                height: height / 4,
                width: width / 1.9,
              ),
            ],
          );
  }



}