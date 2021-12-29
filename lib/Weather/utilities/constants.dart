import 'package:flutter/material.dart';
import 'package:testing_app/constants.dart';

const kOwmUrl = "https://api.openweathermap.org/data/2.5/weather";
const kOwmApiKey = "4c01ecaee5bb1a71086f293f4190feac";

const kConditionTextStyle = TextStyle(
  fontSize: 80.0,
);

const kTempValueTextStyle = TextStyle(
  fontFamily: fontfamily,
  fontWeight: FontWeight.w700,
  fontSize: 100.0,
  color: korangeColor
);

const kTempUnitBoxDecoration = BoxDecoration(
  border: Border(
    bottom: BorderSide(
      width: 5.0,
      color: kPrimaryColor,
    ),
  ),
);

const kTempUnitTextStyle = TextStyle(
  fontFamily: fontfamily,
  fontWeight: FontWeight.w900,
  color: korangeColor,
  fontSize: 50.0,
  height: 1.0,
);

const kTempSubTextStyle = TextStyle(
  fontFamily: fontfamily,
  fontSize: 30.0,
  letterSpacing: 10.0,
  color: kPrimaryColor
);

const kMessageTextStyle = TextStyle(
  fontFamily: fontfamily,
  fontWeight: FontWeight.w900,
  fontSize: 50.0,
);

const kDescriptionTextStyle = TextStyle(
  fontFamily: fontfamily,
  fontSize: 30.0,
  color: kPrimaryColor
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: fontfamily,
  fontWeight: FontWeight.w900,
  color: kPrimaryColor
);

const kSunTitleTextStyle = TextStyle(
    fontSize: 24.0,
    fontFamily: fontfamily,
    fontWeight: FontWeight.w900,
    letterSpacing: 2.0);

const kSunBodyTextStyle = TextStyle(
  fontFamily: fontfamily,
  fontSize: 16.0,
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: "Enter city name",
  hintStyle: TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide.none,
  ),
);
