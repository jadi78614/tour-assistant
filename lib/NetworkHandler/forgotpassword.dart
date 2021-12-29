import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:testing_app/Forgotpassword/enterotpscreen.dart';
import 'package:testing_app/constants.dart';

import 'package:testing_app/Login/login_screen.dart';

class NetworkHandlerForgotPassword {

  Future getOtp(email, context) async {
    http.Response response = await http
        .get(Uri.parse('http://$urlmongo:3000/general/getotp/$email'));
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



  Future checkemail(email, context) async {
    http.Response response = await http
        .get(Uri.parse('http://$urlmongo:3000/general/resetpassword/$email'));
    if (response.statusCode == 200) {

      dynamic code = await getOtp(email,context);
      Future.delayed(
        Duration.zero,
            () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return OtpEnterScreen(email: email,code: code,);
              },
            ),
          );
        },
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
            "User Does Not Exist",
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

  Future savenewpassword(email, context,newpassword) async {
    http.Response response = await http
        .put(Uri.parse('http://$urlmongo:3000/general/resetpassword/$email/$newpassword'));
    if (response.statusCode == 200) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(milliseconds: 1000),
          backgroundColor: kPrimaryColor,
          content: Text(
            // "Password is not matched and Email is not correct",
            "Password update Successfully",
            style: TextStyle(
                color: korangeColor,
                fontWeight: FontWeight.bold,
                fontFamily: fontfamily),
            textAlign: TextAlign.center,
          ),
        ),
      );
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Future.delayed(
        Duration.zero,
            () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const LoginScreen();
              },
            ),
          );
        },
      );
    } else {
      // ignore: avoid_print
      print(" Status code $response.statusCode");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(milliseconds: 1000),
          backgroundColor: kPrimaryColor,
          content: Text(
            // "Password is not matched and Email is not correct",
            "Password did not update Successfully",
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
