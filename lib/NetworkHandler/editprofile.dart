import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:testing_app/constants.dart';

class NetworkHandlerEditProfile {


  Future getdata(id, context, status) async {
    switch (status) {
      case 'TourGuide':
        {
          http.Response response = await http
              .get(Uri.parse('http://$urlmongo/tourguide/getdata/$id'));
          if (response.statusCode == 200) {
            String data = response.body;
            return jsonDecode(data);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(milliseconds: 1000),
                backgroundColor: kPrimaryColor,
                content: Text(
                  // "Password is not matched and Email is not correct",
                  "Something Went Wrong",
                  style: TextStyle(
                      color: korangeColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: fontfamily),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          break;
        }
      case 'Driver':
        {
          http.Response response = await http
              .get(Uri.parse('http://$urlmongo/driver/getdata/$id'));
          if (response.statusCode == 200) {
            String data = response.body;
            return jsonDecode(data);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(milliseconds: 1000),
                backgroundColor: kPrimaryColor,
                content: Text(
                  // "Password is not matched and Email is not correct",
                  "Something Went Wrong",
                  style: TextStyle(
                      color: korangeColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: fontfamily),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          break;
        }
      case 'Hotel':
        {
          http.Response response = await http
              .get(Uri.parse('http://$urlmongo/hotel/getdata/$id'));
          if (response.statusCode == 200) {
            String data = response.body;
            return jsonDecode(data);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(milliseconds: 1000),
                backgroundColor: kPrimaryColor,
                content: Text(
                  // "Password is not matched and Email is not correct",
                  "Something Went Wrong",
                  style: TextStyle(
                      color: korangeColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: fontfamily),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          break;
        }
      case 'TourCompany':
        {
          http.Response response = await http
              .get(Uri.parse('http://$urlmongo/tourcompany/getdata/$id'));
          if (response.statusCode == 200) {
            String data = response.body;
            return jsonDecode(data);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(milliseconds: 1000),
                backgroundColor: kPrimaryColor,
                content: Text(
                  // "Password is not matched and Email is not correct",
                  "Something Went Wrong",
                  style: TextStyle(
                      color: korangeColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: fontfamily),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          break;
        }
      case 'Tourist':
        {
          http.Response response = await http
              .get(Uri.parse('http://$urlmongo/tourists/getdata/$id'));
          if (response.statusCode == 200) {
            String data = response.body;
            return jsonDecode(data);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(milliseconds: 1000),
                backgroundColor: kPrimaryColor,
                content: Text(
                  // "Password is not matched and Email is not correct",
                  "Something Went Wrong",
                  style: TextStyle(
                      color: korangeColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: fontfamily),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          break;
        }
    }


    // http.Response response = await http
    //     .get(Uri.parse('http://192.168.1.107/tourists/getdata/$id'));
    // if (response.statusCode == 200) {
    //   String data = response.body;
    //   return jsonDecode(data);
    // print("Response Data $data");
    // var decodeData = jsonDecode(data);
    // String userid = decodeData['userdata']['_id'];


    // String userr = decodeData['user'];
    // dynamic name;
    // if(userr=='Hotel'){
    //   name = decodeData['userdata']['hotel_name'];
    // }else if(userr=='TourCompany'){
    //   name = decodeData['userdata']['biz_name'];
    // }else{
    //   name = decodeData['userdata']['name'];
    // }
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

  }

  // else {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(
  //       duration: Duration(milliseconds: 1000),
  //       backgroundColor: kPrimaryColor,
  //       content: Text(
  //         // "Password is not matched and Email is not correct",
  //         "Something Went Wrong",
  //         style: TextStyle(
  //             color: korangeColor,
  //             fontWeight: FontWeight.bold,
  //             fontFamily: fontfamily),
  //         textAlign: TextAlign.center,
  //       ),
  //     ),
  //   );
  // }
  // }

  Future updatedata(id, status, name, city, address, password, context) async {
    switch (status) {
      case 'TourGuide':
        {
          print("ID status $status");
          http.Response response = await http
              .put(Uri.parse('http://$urlmongo/tourguide/profile/$id'),
              body: {
                'name': name,
                'password': password,
                'address': address,
                'city': city
              }
          );
          if (response.statusCode == 200) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(milliseconds: 1000),
                backgroundColor: kPrimaryColor,
                content: Text(
                  // "Password is not matched and Email is not correct",
                  "Updated Successfully",
                  style: TextStyle(
                      color: korangeColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: fontfamily),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(milliseconds: 1000),
                backgroundColor: kPrimaryColor,
                content: Text(
                  // "Password is not matched and Email is not correct",
                  "Something Went Wrong",
                  style: TextStyle(
                      color: korangeColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: fontfamily),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          break;
        }
      case 'Driver':
        {
          print("ID status $status");
          http.Response response = await http
              .put(Uri.parse('http://$urlmongo/driver/profile/$id'),
              body: {
                'name': name,
                'password': password,
                'address': address,
                'city': city
              }
          );
          if (response.statusCode == 200) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(milliseconds: 1000),
                backgroundColor: kPrimaryColor,
                content: Text(
                  // "Password is not matched and Email is not correct",
                  "Updated Successfully",
                  style: TextStyle(
                      color: korangeColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: fontfamily),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(milliseconds: 1000),
                backgroundColor: kPrimaryColor,
                content: Text(
                  // "Password is not matched and Email is not correct",
                  "Something Went Wrong",
                  style: TextStyle(
                      color: korangeColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: fontfamily),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          break;
        }
      case 'Hotel':
        {
          print("ID status $status");
          http.Response response = await http
              .put(Uri.parse('http://$urlmongo/hotel/profile/$id'),
              body: {
                'hotel_name': name,
                'password': password,
                'address': address,
                'city': city
              }
          );
          if (response.statusCode == 200) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(milliseconds: 1000),
                backgroundColor: kPrimaryColor,
                content: Text(
                  // "Password is not matched and Email is not correct",
                  "Updated Successfully",
                  style: TextStyle(
                      color: korangeColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: fontfamily),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(milliseconds: 1000),
                backgroundColor: kPrimaryColor,
                content: Text(
                  // "Password is not matched and Email is not correct",
                  "Something Went Wrong",
                  style: TextStyle(
                      color: korangeColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: fontfamily),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          break;
        }
      case 'TourCompany':
        {
          print("ID status $status");
          http.Response response = await http
              .put(Uri.parse('http://$urlmongo/tourcompany/profile/$id'),
              body: {
                'biz_name': name,
                'password': password,
                'address': address,
                'city': city
              }
          );
          if (response.statusCode == 200) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(milliseconds: 1000),
                backgroundColor: kPrimaryColor,
                content: Text(
                  // "Password is not matched and Email is not correct",
                  "Updated Successfully",
                  style: TextStyle(
                      color: korangeColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: fontfamily),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(milliseconds: 1000),
                backgroundColor: kPrimaryColor,
                content: Text(
                  // "Password is not matched and Email is not correct",
                  "Something Went Wrong",
                  style: TextStyle(
                      color: korangeColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: fontfamily),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          break;
        }
      case 'Tourist':
        {
          print("ID status $status");
          http.Response response = await http
              .put(Uri.parse('http://$urlmongo/tourists/profile/$id'),
              body: {
                'name': name,
                'password': password,
                'address': address,
                'city': city
              }
          );
          if (response.statusCode == 200) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(milliseconds: 1000),
                backgroundColor: kPrimaryColor,
                content: Text(
                  // "Password is not matched and Email is not correct",
                  "Updated Successfully",
                  style: TextStyle(
                      color: korangeColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: fontfamily),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(milliseconds: 1000),
                backgroundColor: kPrimaryColor,
                content: Text(
                  // "Password is not matched and Email is not correct",
                  "Something Went Wrong",
                  style: TextStyle(
                      color: korangeColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: fontfamily),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          break;
        }
    }
  }
}

