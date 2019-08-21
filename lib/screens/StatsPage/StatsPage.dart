import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:path_provider/path_provider.dart';

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xff0000ff)),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(18.0),
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            var height = constraints.maxHeight;
            var width = constraints.maxWidth;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xff0000ff),
                      borderRadius: BorderRadius.circular(23)),
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Column(
                      children: <Widget>[
                        Text("How bad your condition is..",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: width / 18,
                                fontWeight: FontWeight.w900)),
                        SizedBox(
                          height: height / 15,
                        ),
                        FutureBuilder(
                          future: _read(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            List<double> numList = [];
                            if (snapshot.hasData) {
                              if (!(snapshot.data == "0")) {
                                snapshot.data.runes.forEach((int rune) {
                                  var character = new String.fromCharCode(rune);
                                  numList.add(double.parse(character));
                                });
                                return Sparkline(
                                  data: numList,
                                  lineColor: Colors.white,
                                  lineWidth: 5.3,
                                );
                              } else {
                                return Text(
                                    "Sorry we dont have enough data... please go record your breath.",
                                    style: TextStyle(color: Colors.white));
                              }
                            } else {
                              return Text(
                                  "Sorry we dont have enough data... please go record your breath.",
                                  style: TextStyle(color: Colors.white));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xff0000ff),
                      borderRadius: BorderRadius.circular(23)),
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Column(
                      children: <Widget>[
                        Text("How good your condition is..",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: width / 18,
                                fontWeight: FontWeight.w900)),
                        SizedBox(
                          height: height / 15,
                        ),
                        FutureBuilder(
                          future: _read(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            List<double> numList = [];
                            if (snapshot.hasData) {
                              snapshot.data.runes.forEach((int rune) {
                                var character = new String.fromCharCode(rune);
                                double value = double.parse(character);
                                double valuetogive;
                                value == 1.0
                                    ? valuetogive = 5.0
                                    : value == 2.0
                                        ? valuetogive = 4.0
                                        : value == 3.0
                                            ? valuetogive = 3.0
                                            : value == 4.0
                                                ? valuetogive = 2.0
                                                : value == 5.0
                                                    ? valuetogive = 1.0
                                                    : value == 0.0
                                                        ? valuetogive = 0.0
                                                        : print('jjac');
                                numList.add(valuetogive);
                              });
                              return Sparkline(
                                data: numList,
                                lineColor: Colors.white,
                                lineWidth: 5.3,
                              );
                            } else {
                              return Text(
                                    "Sorry we dont have enough data... please go record your breath.",
                                    style: TextStyle(color: Colors.white));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
  Future<String> _read() async {
  String text;
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/breath_data.txt');
    text = await file.readAsString();
  } catch (e) {
    print("Couldn't read file");
  }
  return text;
}


}
