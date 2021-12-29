import 'package:testing_app/Weather/utilities/constants.dart';

import 'package:flutter/material.dart';
import 'package:testing_app/constants.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  late String city;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: size.height*0.1),
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage('images/city_background.jpg'),
            //     fit: BoxFit.cover,
            //   ),
            // ),
            // constraints: BoxConstraints.expand(),
            child: Column(
              children: <Widget>[
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: TextButton(
                //     onPressed: () => Navigator.pop(context),
                //     child: Icon(Icons.arrow_back_ios, size: 50.0),
                //   ),
                // ),
                // Container(
                //
                //   child: TextField(
                //     style: TextStyle(color: Colors.black),
                //     decoration: kTextFieldInputDecoration,
                //     onChanged: (value) => city = value,
                //   ),
                // ),
                Text(
                  'Search by Place',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    color: korangeColor,
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 2),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    color: kPrimaryLightColor,
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: TextField(
                    onChanged: (value) => city = value,
                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.place,
                        color: kPrimaryColor,
                      ),
                      hintText: "Enter place to search",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 2),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    color: korangeColor,
                    borderRadius: BorderRadius.circular(29)
                  ),
                  child: TextButton.icon(
                    onPressed: () => Navigator.pop(context, city),
                    icon: Icon(Icons.search, size: 30.0,color: kPrimaryColor,),
                    label: Text('Get Weather', style: kButtonTextStyle),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
