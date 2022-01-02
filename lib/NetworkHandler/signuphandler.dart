import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:testing_app/constants.dart';

import 'package:testing_app/Login/login_screen.dart';

class NetworkHandlerSignupOTP {
  Future getOtp(email, context) async {

    http.Response response1 = await http
        .get(Uri.parse('http://$urlmongo/general/resetpassword/$email'));
    if(response1.statusCode == 200){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(milliseconds: 1000),
          backgroundColor: kPrimaryColor,
          content: Text(
            // "Password is not matched and Email is not correct",
            "Email Already Registered",
            style: TextStyle(
                color: korangeColor,
                fontWeight: FontWeight.bold,
                fontFamily: fontfamily),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    else{
      http.Response response = await http
          .get(Uri.parse('http://$urlmongo/general/getotp/$email'));
      if (response.statusCode == 200) {
        String data = response.body;
        var decodeData = jsonDecode(data);
        print("Decode data $decodeData");
        dynamic code = decodeData['code'];
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(milliseconds: 1000),
            backgroundColor: kPrimaryColor,
            content: Text(
              // "Password is not matched and Email is not correct",
              "OTP Sent Succesfully",
              style: TextStyle(
                  color: korangeColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: fontfamily),
              textAlign: TextAlign.center,
            ),
          ),
        );
        return code;
      } else {
        // ignore: avoid_print
        print(" Status code $response.statusCode");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(milliseconds: 1000),
            backgroundColor: kPrimaryColor,
            content: Text(
              // "Password is not matched and Email is not correct",
              "OTP did not generated successfully",
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

  Future<void> Signupcompletion(
      email, whoyouare, name, password, context) async {
    // List<String> listitems = [
    //   'Tourist',
    //   'Tour Company',
    //   'Driver',
    //   'Tour Guide',
    //   'Hotel'
    // ];
    switch (whoyouare) {
      case 'Tourist':
        {
          print("$email , $password , $name");
          http.Response response = await http.post(
              Uri.parse('http://$urlmongo/tourists/signup'),
              body: {'email': email, 'password': password, 'name': name});
          if (response.statusCode == 200) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration:  Duration(milliseconds: 1000),
                backgroundColor: kPrimaryColor,
                content: Text(
                  // "Password is not matched and Email is not correct",
                  "Signup Succesfully Now signin",
                  style:  TextStyle(
                      color: korangeColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: fontfamily),
                  textAlign: TextAlign.center,
                ),
              ),
            );
            Future.delayed(Duration.zero, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            });
          } else {
            // ignore: avoid_print
            print(" Status code $response.statusCode");
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration:  Duration(milliseconds: 1000),
                backgroundColor: kPrimaryColor,
                content: Text(
                  // "Password is not matched and Email is not correct",
                  "Something went Wrong",
                  style:  TextStyle(
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
      case 'Tour Company':
        {
          http.Response response = await http.post(
              Uri.parse('http://$urlmongo/tourcompany/signup'),
              body: {'email': email, 'password': password, 'biz_name': name});
          if (response.statusCode == 200) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration:  Duration(milliseconds: 1000),
                backgroundColor: kPrimaryColor,
                content: Text(
                  // "Password is not matched and Email is not correct",
                  "Signup Succesfully Now signin",
                  style:  TextStyle(
                      color: korangeColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: fontfamily),
                  textAlign: TextAlign.center,
                ),
              ),
            );
            Future.delayed(Duration.zero, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration:  Duration(milliseconds: 1000),
                backgroundColor: kPrimaryColor,
                content: Text(
                  // "Password is not matched and Email is not correct",
                  "Something went Wrong",
                  style:  TextStyle(
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
          http.Response response = await http.post(
              Uri.parse('http://$urlmongo/driver/signup'),
              body: {'email': email, 'password': password, 'name': name});
          if (response.statusCode == 200) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration:  Duration(milliseconds: 1000),
                backgroundColor: kPrimaryColor,
                content: Text(
                  // "Password is not matched and Email is not correct",
                  "Signup Succesfully Now signin",
                  style:  TextStyle(
                      color: korangeColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: fontfamily),
                  textAlign: TextAlign.center,
                ),
              ),
            );
            Future.delayed(Duration.zero, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration:  Duration(milliseconds: 1000),
                backgroundColor: kPrimaryColor,
                content: Text(
                  // "Password is not matched and Email is not correct",
                  "Something went Wrong",
                  style:  TextStyle(
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
      case 'Tour Guide':
        {
          http.Response response = await http.post(
              Uri.parse('http://$urlmongo/tourguide/signup'),
              body: {'email': email, 'password': password, 'name': name});
          if (response.statusCode == 200) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration:  Duration(milliseconds: 1000),
                backgroundColor: kPrimaryColor,
                content: Text(
                  // "Password is not matched and Email is not correct",
                  "Signup Succesfully Now signin",
                  style:  TextStyle(
                      color: korangeColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: fontfamily),
                  textAlign: TextAlign.center,
                ),
              ),
            );
            Future.delayed(Duration.zero, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration:  Duration(milliseconds: 1000),
                backgroundColor: kPrimaryColor,
                content: Text(
                  // "Password is not matched and Email is not correct",
                  "Something went Wrong",
                  style:  TextStyle(
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
          http.Response response = await http.post(
              Uri.parse('http://$urlmongo/hotel/signup'),
              body: {'email': email, 'password': password, 'hotel_name': name});
          if (response.statusCode == 200) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration:  Duration(milliseconds: 1000),
                backgroundColor: kPrimaryColor,
                content: Text(
                  // "Password is not matched and Email is not correct",
                  "Signup Succesfully Now signin",
                  style:  TextStyle(
                      color: korangeColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: fontfamily),
                  textAlign: TextAlign.center,
                ),
              ),
            );
            Future.delayed(Duration.zero, () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration:  Duration(milliseconds: 1000),
                backgroundColor: kPrimaryColor,
                content: Text(
                  // "Password is not matched and Email is not correct",
                  "Something went Wrong",
                  style:  TextStyle(
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
