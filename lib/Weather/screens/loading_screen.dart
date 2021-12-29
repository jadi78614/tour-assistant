
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:testing_app/Weather/services/weather.dart';
import 'package:testing_app/constants.dart';

import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  getLocationData() async {
    WeatherModel model = WeatherModel();
    var data = await model.getLocationWeather();
    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationScreen(locationWeather: data),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(korangeColor),
            ),
            SizedBox(height: 20.0),
            // Text("Loading the weather data..."),
          ],
        ),
      ),
    );
  }
}
