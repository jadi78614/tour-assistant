import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:testing_app/constants.dart';
import 'package:testing_app/Dashboard/TouristDashboard/user_dashboard.dart';
import 'package:testing_app/Dashboard/DriverDashboard/driver_dashboard.dart';
import 'package:testing_app/Dashboard/HotelDashboard/hotel_dashboard.dart';
import 'package:testing_app/Dashboard/TourCompany/tourcompany_dashboard.dart';
import 'package:testing_app/Dashboard/TourGuide/tourguide_dashboard.dart';

class NetworkHandlerLogin {
  void getData(email, password, context) async {
    http.Response response = await http.get(
        Uri.parse('http://$urlmongo:3000/general/login/$email/$password'));
    if (response.statusCode == 200) {
      String data = response.body;
      print("Response Data $data");
      var decodeData = jsonDecode(data);
      String userid = decodeData['userdata']['_id'];
      print("Test 1");
      String address = decodeData['userdata']['address'];
      print("Test 2");
      String city = decodeData['userdata']['city'];
      print("Test 3");
      String password = decodeData['userdata']['password'];
      print("Test 4");
      String userr = decodeData['user'];
      print("Test 5");
      dynamic name;
      if (userr == 'Hotel') {
        name = decodeData['userdata']['hotel_name'];
      } else if (userr == 'TourCompany') {
        name = decodeData['userdata']['biz_name'];
      } else {
        name = decodeData['userdata']['name'];
      }
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(
      //     duration: Duration(milliseconds: 1000),
      //     backgroundColor: kPrimaryColor,
      //     content: Text(
      //       // "Password is not matched and Email is not correct",
      //       "Login Successfully",
      //       style:  TextStyle(
      //           color: korangeColor,
      //           fontWeight: FontWeight.bold,
      //           fontFamily: fontfamily),
      //       textAlign: TextAlign.center,
      //     ),
      //   ),
      // );
      switch (userr) {
        case 'TourGuide':
          {
            Navigator.pop(context);
            Future.delayed(Duration.zero, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return TourGuideDashboard(
                      name: name,
                      stringid: userid,
                      city: city,
                      address: address,
                      password: password,
                      email: email,
                      status: userr,
                    );
                  },
                ),
              );
            });
            break;
          }
        case 'Driver':
          {
            Navigator.pop(context);
            Future.delayed(Duration.zero, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return DriverDashboard(
                      name: name,
                      stringid: userid,
                      status: userr,
                      email: email,
                      city: city,
                      address: address,
                      password: password,
                    );
                  },
                ),
              );
            });
            break;
          }
        case 'Hotel':
          {
            Navigator.pop(context);
            Future.delayed(Duration.zero, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return HotelDashboard(
                      name: name,
                      stringid: userid,
                      status: userr,
                      email: email,
                      city: city,
                      address: address,
                      password: password,
                    );
                  },
                ),
              );
            });
            break;
          }
        case 'TourCompany':
          {
            Navigator.pop(context);
            Future.delayed(Duration.zero, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return TourCompanyDashboard(
                      name: name,
                      stringid: userid,
                      status: userr,
                      email: email,
                      city: city,
                      address: address,
                      password: password,
                    );
                  },
                ),
              );
            });
            break;
          }
        case 'Tourist':
          {
            Navigator.pop(context);
            Future.delayed(Duration.zero, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    print(
                        "email $email , userr $userr name$name  stringid $userid");
                    return UserDashboard(
                      name: name,
                      stringid: userid,
                      status: userr,
                      email: email,
                      city: city,
                      address: address,
                      password: password,
                    );
                  },
                ),
              );
            });
            break;
          }
      }
    } else {
      // ignore: avoid_print
      print(" Status code $response.statusCode");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(milliseconds: 1000),
          backgroundColor: kPrimaryColor,
          content: Text(
            // "Password is not matched and Email is not correct",
            "Wrong ID or Password",
            style: TextStyle(
                color: korangeColor,
                fontWeight: FontWeight.bold,
                fontFamily: fontfamily),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }
}
