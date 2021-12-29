import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiver/async.dart';
import 'package:testing_app/Login/login_screen.dart';
import 'package:testing_app/NetworkHandler/forgotpassword.dart';
import 'package:testing_app/NetworkHandler/signuphandler.dart';
import 'package:testing_app/Signup/signup_screen.dart';
import 'package:testing_app/constants.dart';
import 'package:testing_app/Signup/singupemailverification.dart';
import 'package:testing_app/Dashboard//TouristDashboard/user_dashboard.dart';
import 'package:testing_app/Forgotpassword/forgotpassword.dart';

import 'enterpasswordscreen.dart';

class OtpEnterScreen extends StatelessWidget {
  final int code;
  final email;
  const OtpEnterScreen({Key? key, required this.email, required this.code})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OtpEnterScreenWidget(code: code,email: email,),
    );
  }
}

class OtpEnterScreenWidget extends StatefulWidget {
  final int code;
  final email;

  const OtpEnterScreenWidget({
    required this.code,
    required this.email,
    Key? key,
  }): super(key: key);
  @override
  State createState() => _MediaQueryWidgetStateLogin();
}

class _MediaQueryWidgetStateLogin extends State<OtpEnterScreenWidget> {


  @override
  void initState() {
    super.initState();
    startTimer();
  }

  bool suffixcheck = true;
  IconData iconvisibility = Icons.visibility;
  late String email = widget.email;
  bool checkverification = true;
  late int testotp = widget.code;

  int onetimep = 0;
  int _start = 20;
  dynamic _current = 0;
  bool generateotp = false;
//var _scaffoldKey = GlobalKey<ScaffoldState>();
//   CountdownTimer? countDownTimer;
//   late dynamic sub = countDownTimer!.listen(null);
  late CountdownTimer countDownTimer;
  var sub;
  void startTimer() {
    countDownTimer =  CountdownTimer(
       Duration(seconds: _start),
       Duration(seconds: 1),
    );

    sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() { _current = _start - duration.elapsed.inSeconds; });
    });

    sub.onDone(() {
      generateotp = false;
      print("Done $generateotp");
      sub.cancel();
    });
  }

  // void startTimer() {
  //   countDownTimer = CountdownTimer(
  //     Duration(seconds: _start),
  //     Duration(seconds: 1),
  //   );
  //
  //   sub.onData((duration) {
  //     setState(() {
  //       _current = _start - duration.elapsed.inSeconds;
  //     });
  //   });
  //
  //   sub.onDone(() {
  //     print("Done");
  //     generateotp = false;
  //     sub.cancel();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // Positioned(
          //   child: Image.asset(
          //     "assets/images/signup_top.png",
          //     width: size.width * 0.35,
          //   ),
          //   top: 0,
          //   left: 0,
          // ),
          Positioned(
            child: Image.asset(
              "assets/images/main_bottom.png",
              width: size.width * 0.3,
            ),
            bottom: -60,
            left: 0,
          ),
          // Positioned(
          //   top: size.height * 0.08,
          //   child: Image.asset(
          //     "assets/images/enterotp.png",
          //     width: size.width * 0.6,
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.1),
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: size.height * 0.1),
                    const Text(
                      ("Enter OTP "),
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 60,
                        color: kPrimaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image.asset(
                        "assets/images/enterotp.png",
                        width: size.width * 0.6,
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(100),
                    //   child: SvgPicture.asset(
                    //     "assets/icons/avatar.svg",
                    //     color: kPrimaryLightColor,
                    //   ),
                    // ),
                    // SizedBox(height: size.height * 0.05),

                    // Container(
                    //   margin: const EdgeInsets.symmetric(vertical: 5),
                    //   padding:
                    //       // const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    //       const EdgeInsets.only(
                    //           left: 20, top: 2, bottom: 2, right: 3),
                    //   width: size.width * 0.8,
                    //   decoration: BoxDecoration(
                    //     color: kPrimaryLightColor,
                    //     borderRadius: BorderRadius.circular(29),
                    //   ),
                    //   child: TextField(
                    //     textInputAction: TextInputAction.next,
                    //     onChanged: (value) {
                    //       email = value;
                    //     },
                    //     cursorColor: kPrimaryColor,
                    //     decoration: const InputDecoration(
                    //       icon: Icon(
                    //         Icons.person,
                    //         color: kPrimaryColor,
                    //       ),
                    //       hintText: "Email",
                    //       border: InputBorder.none,
                    //     ),
                    //   ),
                    // ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                        color: kPrimaryLightColor,
                        borderRadius: BorderRadius.circular(29),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        onChanged: (value) {
                          if (value == '') {
                            setState(() {
                              checkverification = true;
                            });
                          } else {
                            onetimep = int.parse(value);
                            setState(() {
                              checkverification = false;
                            });
                          }
                        },
                        cursorColor: kPrimaryColor,
                        decoration: const InputDecoration(
                          icon: Icon(
                            Icons.password_outlined,
                            color: kPrimaryColor,
                          ),
                          hintText: "Enter One Time Password",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: EdgeInsets.only(right: size.width * 0.15),
                        child: TextButton(
                          onPressed: generateotp
                              ? () {

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: Duration(milliseconds: 1000),
                                      backgroundColor: kPrimaryColor,
                                      content: Text(
                                        // "Password is not matched and Email is not correct",
                                        "Wait for $_current seconds before retrying",
                                        style: const TextStyle(
                                            color: korangeColor,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: fontfamily),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                }
                              : () async {
                                  generateotp = true;
                                  if (EmailValidator.validate(email)) {
                                    NetworkHandlerForgotPassword getdata =
                                    NetworkHandlerForgotPassword();
                                    dynamic check =
                                        await getdata.getOtp(email, context);
                                    testotp = check;
                                    startTimer();
                                    print("Test otp dynamic $testotp");
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        duration: Duration(milliseconds: 1000),
                                        backgroundColor: kPrimaryColor,
                                        content: Text(
                                          // "Password is not matched and Email is not correct",
                                          "Enter Correct Email",
                                          style: TextStyle(
                                              color: korangeColor,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: fontfamily),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  }

                                  // ScaffoldMessenger.of(context).showSnackBar(
                                  //   const SnackBar(
                                  //     duration: Duration(milliseconds: 1000),
                                  //     backgroundColor: kPrimaryColor,
                                  //     content: Text(
                                  //       // "Password is not matched and Email is not correct",
                                  //       "OTP Sent",
                                  //       style: TextStyle(
                                  //           color: korangeColor,
                                  //           fontWeight: FontWeight.bold,
                                  //           fontFamily: fontfamily),
                                  //       textAlign: TextAlign.center,
                                  //     ),
                                  //   ),
                                  // );
                                },
                          child: Text(
                            "ReSend OTP",
                            style: TextStyle(
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    //Text("$_current"),

                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      width: size.width * 0.8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: ElevatedButton(
                          onPressed: checkverification
                              ? () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      duration: Duration(milliseconds: 1000),
                                      backgroundColor: kPrimaryColor,
                                      content: Text(
                                        // "Password is not matched and Email is not correct",
                                        "Enter OTP First",
                                        style: TextStyle(
                                            color: korangeColor,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: fontfamily),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                }
                              : () {

                                  if (onetimep == testotp) {
                                    sub.cancel();
                                    Navigator.pop(context);
                                    Future.delayed(Duration.zero, () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return EnterPassword(email: email,);
                                          },
                                        ),
                                      );
                                    });
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        duration: Duration(milliseconds: 1000),
                                        backgroundColor: kPrimaryColor,
                                        content: Text(
                                          // "Password is not matched and Email is not correct",
                                          "Invalid OTP",
                                          style: TextStyle(
                                              color: korangeColor,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: fontfamily),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  }
                                },
                          child: Text(
                            checkverification ? "Enter Otp" : "Reset Password",
                            style: const TextStyle(color: kPrimaryColor),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: korangeColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            textStyle: const TextStyle(
                                color: kPrimaryColor,
                                fontSize: 14,
                                fontFamily: fontfamily,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 0.1),
                    // Center(
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: <Widget>[
                    //       const Text(
                    //         "Already have an Account ?",
                    //         style: TextStyle(color: kPrimaryColor),
                    //       ),
                    //       GestureDetector(
                    //         onTap: () {
                    //           sub.cancel();
                    //           Navigator.pop(context);
                    //           Future.delayed(
                    //             Duration.zero,
                    //             () {
                    //               Navigator.push(
                    //                 context,
                    //                 MaterialPageRoute(
                    //                   builder: (context) {
                    //                     return const LoginScreen();
                    //                   },
                    //                 ),
                    //               );
                    //             },
                    //           );
                    //         },
                    //         child: const Text(
                    //           " Login",
                    //           style: TextStyle(
                    //             color: korangeColor,
                    //             fontWeight: FontWeight.bold,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
