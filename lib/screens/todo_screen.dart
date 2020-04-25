import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:farming_app/models/Weather.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlatButton(
            child: Text('Get weather'),
            onPressed: () {
              getCurrentPosition();
            },
          ),
          RichText(
            text: new TextSpan(
                text: "Powered by ClimaCell",
                style: new TextStyle(color: Colors.black),
                recognizer: new TapGestureRecognizer()
                  ..onTap = () {launch("https://www.climacell.co/");}
            ),
          )
        ],
      ),
    );
  }

  getCurrentPosition() async {
    PermissionStatus status = await Permission.locationWhenInUse.status;
    print(status);
    if (status.isUndetermined) {
      if (await Permission.locationWhenInUse
          .request()
          .isGranted) {
        Position position = await Geolocator().getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        print(position.latitude.toString() + "     " +
            position.longitude.toString());
        http.get("https://api.climacell.co/v3/weather/forecast/hourly",
            headers: {'lat': position.latitude.toString(),
              'lon': position.longitude.toString()}).then((value) {
          print(value.body);
        });
      }
    }
    else {
      print('here');
      Position position = await Geolocator().getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print(position.latitude.toString() + "     " +
          position.longitude.toString());
      http.get(
          "https://api.climacell.co/v3/weather/forecast/hourly?lat=${position
              .latitude}&lon=${position.longitude}", headers: {
        'apikey': 'iTiPDrLOgggoGVXeDu2W5q7qjDP1Xmd6',}).then((value) {
        var data = json.decode(value.body);
        print(data);
        for (int i = 0; i < data.length; i++) {
          Weather weather = Weather.fromJson(data[i]);
          print('Time: ${weather.observation_time} Precipitation: ${weather.precipitation_value} ${weather.precipitation_units}');
        }
      });
    }
  }
}
