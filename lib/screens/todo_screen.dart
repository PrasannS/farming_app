import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farming_app/api_client/api_client.dart';
import 'package:farming_app/screens/videos_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:farming_app/models/Weather.dart';
import 'package:url_launcher/url_launcher.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List dayTasks = [
    'water the tomatos',
    'plant the tpotatoes',
    'water the weed',
    'harvest the weed',
    'water the tomatos',
    'plant the tpotatoes',
    'water the weed',
    'harvest the weed'
  ];
  List weekTasks = [
    'weektask1',
    'weektask12',
    'weektask3',
    'weektask4',
    'weektask5'
  ];
  List monthTasks = [
    'monthTask1',
    'monthTask2',
    'monthTask3',
    'monthTask4',
    'monthTask5'
  ];
  int pageIndex = 0;
  double total;
  String currentUserId;

  //TODO list of booleans to fil up, and string names of the produce. If smth is toPlant then it will take to YT Page
  List<bool> toPlant = [];
  List<String> produce_names = [];

  //ranges of how much water to give.
  List<List<double>> ranges = [];
  bool fullyloaded = false;

  @override
  void initState() {
    super.initState();

    getRainfall();
    getData();
  }

  Future getProduceData() async {
    await FirebaseAuth.instance.currentUser().then((value) {
      currentUserId = value.uid;
    });
    DocumentSnapshot currentUser = await Firestore.instance
        .collection('users')
        .document(currentUserId)
        .get();

    if (currentUser.data['posts'] != null) {
      for (int i = 0; i < currentUser.data['posts'].length; i++) {
        DocumentSnapshot eachPost = await Firestore.instance
            .collection('posts')
            .document(currentUser.data['posts'][i])
            .get();
        produce_names.add(eachPost.data['type']);
        toPlant.add(!eachPost.data['planted']);
      }
    }
    setState(() {});
  }

  Future getData() async {
    await getProduceData();
    await getRanges();
    setState(() {
      fullyloaded = true;
    });
  }

  //TODO set up so that the expected rainfall in inches is subtracted.
  Future getRanges() async {
    for (int i = 0; i < toPlant.length; i++) {
      await fetchWaterResult(produce_names[i]).then((value) {
        setState(() {
          ranges.add(value);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'To Do List',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        FaIcon(
          FontAwesomeIcons.cloudRain,
          size: 100.0,
        ),
        SizedBox(
          height: 30.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            new RichText(
              textAlign: TextAlign.right,
              text: new TextSpan(
                  text: 'Powered by ClimaCell',
                  style: new TextStyle(color: Colors.black,),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () { launch('https://www.climacell.co/');
                    }
              ),),
          ],
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0)),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          pageIndex = 0;
                        });
                      },
                      child: Text(
                        'Today',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: pageIndex == 0
                              ? FontWeight.bold
                              : FontWeight.w400,
                          // decoration: pageIndex == 1 ? TextDecoration.underline
                          //     : TextDecoration.none
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          pageIndex = 1;
                        });
                      },
                      child: Text(
                        'Week',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: pageIndex == 1
                              ? FontWeight.bold
                              : FontWeight.w400,
                          // decoration: pageIndex == 1 ? TextDecoration.underline
                          //     : TextDecoration.none
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          pageIndex = 2;
                        });
                      },
                      child: Text(
                        'Month',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: pageIndex == 2
                              ? FontWeight.bold
                              : FontWeight.w400,
                          // decoration: pageIndex == 1 ? TextDecoration.underline
                          //     : TextDecoration.none
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Divider(
                  thickness: 3.0,
                ),
                fullyloaded
                    ? Expanded(
                        child: ListView.builder(
                            itemCount: toPlant.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.8),
                                          blurRadius:
                                              3.0, // has the effect of softening the shadow
                                          spreadRadius:
                                              1.0, // has the effect of extending the shadow
                                          offset: Offset(
                                            4.0, // horizontal, move right 10
                                            4.0, // vertical, move down 10
                                          ),
                                        ),
                                      ]),
                                  height: 50.0,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon:
                                            Icon(Icons.radio_button_unchecked),
                                        onPressed: () {
                                          //TODO What happens when a task is completed?
                                        },
                                      ),
                                      GestureDetector(
                                          onTap: toPlant[index]
                                              ? () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            VideosPage(
                                                              item:
                                                                  produce_names[
                                                                      index],
                                                            )),
                                                  );
                                                }
                                              : null,
                                          child: Text(
                                            toPlant[index]
                                                ? "Plant " +
                                                    produce_names[index]
                                                : "Water " +
                                                    produce_names[index] +
                                                    " " +
                                                    ranges[index].toString() + " - ${total}"
                                                    " inches",
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w500),
                                          )),
                                    ],
                                  ),
                                ),
                              );
                            }))
                    : Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        )
      ]),
    );
  }

  //TODO set up to get inches of rainfall predicted for the rest of the week
  Future<double> getRainfall() async {
    PermissionStatus status = await Permission.locationWhenInUse.status;
    print(status);
    if (status.isUndetermined) {
      if (await Permission.locationWhenInUse.request().isGranted) {
        Position position = await Geolocator()
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        print(position.latitude.toString() +
            "     " +
            position.longitude.toString());
        http.get(
            "https://api.climacell.co/v3/weather/forcase/hourly?lat=${position.latitude}&lon=${position.longitude}&unit_system=us",
            headers: {
              'apikey': 'iTiPDrLOgggoGVXeDu2W5q7qjDP1Xmd6'
            }).then((value) {
          print(value.body);
          var data = json.decode(value.body);
          total = 0;
          int ind = 0;
          int lastDay = DateTime.now().day;
          for (int i = 0; i < data.length; i++) {
            Weather weather = Weather.fromJson(data[i]);
            print(
                'Time: ${weather.observation_time} Precipitation: ${weather.precipitation_value} ${weather.precipitation_units}');
            total += weather.precipitation_value;
          }
        });
      }
    } else {
      print('here');
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print(position.latitude.toString() +
          "     " +
          position.longitude.toString());
      http.get(
          "https://api.climacell.co/v3/weather/forecast/hourly?lat=${position.latitude}&lon=${position.longitude}&unit_system=us",
          headers: {
            'apikey': 'iTiPDrLOgggoGVXeDu2W5q7qjDP1Xmd6',
          }).then((value) {
        var data = json.decode(value.body);
        print(data);
        total = 0;
        int ind = 0;
        int lastDay = DateTime.now().day;
        for (int i = 0; i < data.length; i++) {
          Weather weather = Weather.fromJson(data[i]);
          print(
              'Time: ${weather.observation_time} Precipitation: ${weather.precipitation_value} ${weather.precipitation_units}');
          total += weather.precipitation_value;
        }
      });
    }
  }
}
