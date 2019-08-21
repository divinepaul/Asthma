import 'dart:io';

import 'package:asthma/screens/StatsPage/StatsPage.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:path_provider/path_provider.dart';

class RecordPage extends StatefulWidget {
  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  static AudioCache player = new AudioCache();
  var _value = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asthma',
      theme: ThemeData(
        primaryColor: Color(0xff0000ff),
      ),
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(18.0),
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              var height = constraints.maxHeight;
              var width = constraints.maxWidth;

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: width / 1.5,
                        child: Text("how easy are you breathing today?",
                            softWrap: true,
                            style: TextStyle(
                                color: Color(0xff0000ff),
                                fontSize: width / 14,
                                fontWeight: FontWeight.w900)),
                      ),
                      FloatingActionButton(
                        child: Icon(
                          Icons.done,
                          color: Colors.green,
                        ),
                        onPressed: () {
                          if (_value.toInt() == 0) {
                            Scaffold.of(context).showSnackBar(snackBar);
                          } else {
                            if (_value.toInt() == 6) {
                              setState(() {
                                _value = 5;
                              });

                              _write(_value.toString());
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StatisticsPage()),
                              );
                            } else {
                              _write(_value.toString());
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StatisticsPage()),
                              );
                            }
                          }
                        },
                        elevation: 20,
                        backgroundColor: Colors.white,
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    height: height / 1.5,
                    decoration: BoxDecoration(
                      color: Color(0xff0000ff),
                      borderRadius: BorderRadius.circular(23),

                      // boxShadow: [
                      //   BoxShadow(spreadRadius: 13,blurRadius: 43,offset: Offset(0, 30),color: Color(0x88000000))
                      // ]
                    ),
                    child: Row(
                      children: <Widget>[
                        FlutterSlider(
                          trackBar: FlutterSliderTrackBar(
                              activeTrackBarColor: Colors.white,
                              inactiveTrackBarColor: Colors.white),
                          handler: FlutterSliderHandler(
                              child: Container(
                            child: Icon(
                              Icons.expand_more,
                              color: Color(0xff0000ff),
                            ),
                          )),
                          min: 0,
                          max: 6,
                          axis: Axis.vertical,
                          values: <double>[0, 6],
                          onDragCompleted:
                              (handlerIndex, lowerValue, upperValue) {
                            setState(() {
                              if (lowerValue.toInt() == 6) {
                                _value = 5;
                              } else {
                                _value = lowerValue.toInt();
                              }
                            });
                            player.play('jj.mp3');
                          },
                          onDragging: (handlerIndex, lowerValue, upperValue) {
                            setState(() {
                              _value = lowerValue.toInt();
                            });
                          },
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              '',
                              style: TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Easy!',
                              style: TextStyle(
                                  color: _value == 1
                                      ? Color(0xffffffff)
                                      : Color(0xAAFFFFFF),
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Somewhat easy',
                              style: TextStyle(
                                  color: _value == 2
                                      ? Color(0xffffffff)
                                      : Color(0xAAFFFFFF),
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'usual',
                              style: TextStyle(
                                  color: _value == 3
                                      ? Color(0xffffffff)
                                      : Color(0xAAFFFFFF),
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'somewhat hard',
                              style: TextStyle(
                                  color: _value == 4
                                      ? Color(0xffffffff)
                                      : Color(0xAAFFFFFF),
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Hard!',
                              style: TextStyle(
                                  color: _value == 5
                                      ? Color(0xffffffff)
                                      : Color(0xAAFFFFFF),
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  _write(String text) async {
    String tempVal = await _read();
    if (tempVal == null) {
      tempVal = "0";
    }
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/breath_data.txt');
    await file.writeAsString(tempVal + text);
    print('done');
  }

  final snackBar = SnackBar(
    backgroundColor: Color(0xff0000ff),
    content: Text(
      'Drag the Slider down and choose..',
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    action: SnackBarAction(
      textColor: Colors.white,
      label: 'OK',
      onPressed: () {
        // Some code to undo the change!
      },
    ),
  );

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