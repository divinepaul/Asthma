import 'package:asthma/screens/DashBoard/Widgets/DashBoardItem.dart';
import 'package:flutter/material.dart';


class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              var height = constraints.maxHeight;
              var width = constraints.maxWidth;

              return Stack(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Asthma.",
                          style: TextStyle(
                              color: Color(0xff0000ff),
                              fontSize: 45,
                              fontWeight: FontWeight.w900)),
                      DashBoardItem(
                        height: height,
                        width: width,
                        text: "how's today's breath?",
                        asset: 'assets/check-img.png',
                        orderReverse: false,
                      ),
                      DashBoardItem(
                        height: height,
                        width: width,
                        text: "check if you improve.",
                        asset: 'assets/stat.png',
                        orderReverse: true,
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
