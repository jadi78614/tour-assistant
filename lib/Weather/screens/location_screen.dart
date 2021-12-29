
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/Weather/services/weather.dart';
import 'package:testing_app/Weather/utilities/constants.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;

  LocationScreen({this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late int temp;
  late String city, weatherIcon, message, description, countryCode;
  late Duration timeBeforeSunset, timeBeforeSunrise;
  WeatherModel model = WeatherModel();

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic data) {
    setState(() {
      if (data == null) {
        temp = 0;
        weatherIcon = "Error";
        message = "Unable to get weather data";
        description = "";
        city = "";
        countryCode = "";
        timeBeforeSunrise = Duration();
        timeBeforeSunset = Duration();
        return;
      }

      temp = (data["main"]["temp"] as double).floor();
      weatherIcon = model.getWeatherIcon(data["weather"][0]["id"]);
      message = model.getMessage(temp);
      description = data["weather"][0]["description"];
      city = data["name"];
      countryCode = data["sys"]["country"];
      DateTime now = DateTime.now().toUtc();
      DateTime sunrise = DateTime.fromMillisecondsSinceEpoch(
        data["sys"]["sunrise"] * 1000,
        isUtc: true,
      );
      DateTime sunset = DateTime.fromMillisecondsSinceEpoch(
        data["sys"]["sunset"] * 1000,
        isUtc: true,
      );
      timeBeforeSunrise = now.difference(sunrise);
      timeBeforeSunset = now.difference(sunset);
    });
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    Size size = MediaQuery.of(context).size;
    return Container(
          decoration: BoxDecoration(
            // image: DecorationImage(
            //     image: AssetImage('images/location_background.jpg'),
            //     fit: BoxFit.cover,
            //     colorFilter: ColorFilter.mode(
            //       Colors.white.withOpacity(0.5),
            //       BlendMode.dstATop,
            //     )),
            color: Colors.white
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                // top: size.height * 0.05,
                // left: size.width * 0.05,
                padding: EdgeInsets.only(top: size.height * 0.05,
                    left: size.width * 0.05),
                child: Row(
                  children: [
                    Builder(builder: (context) {
                      return IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: kPrimaryColor,
                          size: 35,
                        ),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text("Weather",style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 20
                      ),),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextButton(
                      onPressed: () async {
                        var data = await model.getLocationWeather();
                        updateUI(data);
                      },
                      child: Icon(Icons.near_me, size: 50.0,color: korangeColor,),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextButton(
                      onPressed: () async {
                        var typedCity = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CityScreen()),
                        );

                        if (typedCity != null) {
                          var data = await model.getCityWeather(typedCity);
                          updateUI(data);
                        }
                      },
                      child: Icon(Icons.travel_explore_outlined, size: 50.0,color: kPrimaryColor,),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(weatherIcon, style: kConditionTextStyle),
                  Row(
                    children: [
                      Text(temp.toString(), style: kTempValueTextStyle),
                      SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // decoration: kTempUnitBoxDecoration,
                            child: Text("O", style: kTempUnitTextStyle),
                          ),
                          Text("now", style: kTempSubTextStyle),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Text(
                    //   "$message",
                    //   textAlign: TextAlign.right,
                    //   style: kMessageTextStyle,
                    // ),
                    SizedBox(height: 10.0),
                    Center(
                      child: Text.rich(
                        TextSpan(
                            text: "There's $description in ",
                            style: kDescriptionTextStyle,
                            children: [
                              TextSpan(
                                  text: "$city, $countryCode",
                                  style: TextStyle(fontStyle: FontStyle.italic,))
                            ]),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.all(20.0),
              //   child: Container(
              //     decoration: BoxDecoration(
              //       color: Colors.blueGrey,
              //       border: Border.all(color: Colors.blueGrey, width: 3.0),
              //       borderRadius: BorderRadius.circular(50.0),
              //     ),
              //     child: Padding(
              //       padding:
              //           EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
              //       child: Column(
              //         children: [
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               // Image.asset(
              //               //   "images/sunrise.png",
              //               //   width: 64.0,
              //               // ),
              //               Column(
              //                 crossAxisAlignment: CrossAxisAlignment.end,
              //                 children: [
              //                   Text(
              //                     "${timeBeforeSunrise.inHours.abs()}h ${timeBeforeSunrise.inMinutes % 60}min",
              //                     style: kSunTitleTextStyle,
              //                   ),
              //                   Text(
              //                     "${timeBeforeSunrise.isNegative ? "before" : "after"} sunrise",
              //                     style: kSunBodyTextStyle,
              //                   ),
              //                 ],
              //               ),
              //             ],
              //           ),
              //           SizedBox(
              //             height: 10.0,
              //           ),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               // Image.asset(
              //               //   "images/sunset.png",
              //               //   width: 64.0,
              //               // ),
              //               Column(
              //                 crossAxisAlignment: CrossAxisAlignment.end,
              //                 children: [
              //                   Text(
              //                     "${timeBeforeSunset.inHours.abs()}h ${timeBeforeSunset.inMinutes % 60}min",
              //                     style: kSunTitleTextStyle,
              //                   ),
              //                   Text(
              //                     "${timeBeforeSunset.isNegative ? "before" : "after"} sunset",
              //                     style: kSunBodyTextStyle,
              //                   ),
              //                 ],
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),

    );
  }
}
