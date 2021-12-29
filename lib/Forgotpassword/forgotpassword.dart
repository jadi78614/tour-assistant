import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:quiver/async.dart';
import 'package:testing_app/Login/login_screen.dart';
import 'package:testing_app/NetworkHandler/forgotpassword.dart';
import 'package:testing_app/NetworkHandler/signuphandler.dart';
import 'package:testing_app/Signup/signup_screen.dart';
import 'package:testing_app/constants.dart';
import 'package:testing_app/Forgotpassword/enterotpscreen.dart';

class FogotPassword extends StatelessWidget {
  const FogotPassword({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ForgotPasswordScreen(),
    );
  }
}

class ForgotPasswordScreen extends StatefulWidget {
  @override
  State createState() => _MediaQueryWidgetStateSignUp();
}

class _MediaQueryWidgetStateSignUp extends State<ForgotPasswordScreen> {
  bool suffixcheck = true;
  IconData iconvisibility = Icons.visibility;
  String email = "";
  bool checkverification = true;
  int testotp = 0;
  int onetimep = 0;
  // int _start = 20;
  // dynamic _current = 0;
  bool generateotp = false;

  int _start = 10;
  int _current = 10;

  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _start),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() { _current = _start - duration.elapsed.inSeconds; });
    });

    sub.onDone(() {
      generateotp = false;
      print("Done $generateotp");
      sub.cancel();
    });
  }

  //var _scaffoldKey = GlobalKey<ScaffoldState>();
  // CountdownTimer? countDownTimer;
  // late dynamic sub = countDownTimer!.listen(null);
  // void startTimer() {
  //   countDownTimer = CountdownTimer(
  //     Duration(seconds: _start),
  //     Duration(seconds: 1),
  //   );
  //   print("In timeer");
  //   sub.onData((duration) {
  //     print("in start timer");
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
          Positioned(
            bottom: size.height * 0.65,
            child: Image.asset(
              "assets/images/resetpassword.png",
              width: size.width * 0.6,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: size.height * 0.1),
                const Text(
                  ("Reset Password"),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 60,
                    color: korangeColor,
                  ),
                  textAlign: TextAlign.center,
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

                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding:
                      // const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                      const EdgeInsets.only(
                          left: 20, top: 2, bottom: 2, right: 3),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    color: kPrimaryLightColor,
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: TextField(
                    key: ValueKey("email"),
                    textInputAction: TextInputAction.next,
                    onChanged: (value) {
                      email = value;
                    },
                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: kPrimaryColor,
                      ),
                      hintText: "Email",
                      border: InputBorder.none,
                      // suffixIcon: ClipRRect(
                      //   borderRadius: BorderRadius.circular(30),
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //       if (password != password2) {
                      //         ScaffoldMessenger.of(context).showSnackBar(
                      //           const SnackBar(
                      //             duration: Duration(milliseconds: 1000),
                      //             backgroundColor: kPrimaryColor,
                      //             content: Text(
                      //               // "Password is not matched and Email is not correct",
                      //               "OTP Sent",
                      //               style: TextStyle(
                      //                   color: korangeColor,
                      //                   fontWeight: FontWeight.bold,
                      //                   fontFamily: fontfamily),
                      //               textAlign: TextAlign.center,
                      //             ),
                      //           ),
                      //         );
                      //       }
                      //     },
                      //     child: const Text(
                      //       "Send Otp",
                      //       style: TextStyle(color: kPrimaryLightColor),
                      //     ),
                      //     style: ElevatedButton.styleFrom(
                      //       primary: kPrimaryColor,
                      //       textStyle: const TextStyle(
                      //           color: korangeColor,
                      //           fontSize: 14,
                      //           fontFamily: fontfamily,
                      //           fontWeight: FontWeight.w500),
                      //     ),
                      //   ),
                      // ),
                    ),
                  ),
                ),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: Container(
                //     margin: EdgeInsets.only(right: size.width * 0.15),
                //     child: TextButton(
                //
                //       onPressed:generateotp?(){
                //
                //         ScaffoldMessenger.of(context).showSnackBar(
                //           SnackBar(
                //             duration: Duration(milliseconds: 1000),
                //             backgroundColor: kPrimaryColor,
                //             content: Text(
                //               // "Password is not matched and Email is not correct",
                //               "Wait for $_current seconds before retrying",
                //               style: const TextStyle(
                //                   color: korangeColor,
                //                   fontWeight: FontWeight.bold,
                //                   fontFamily: fontfamily),
                //               textAlign: TextAlign.center,
                //             ),
                //           ),
                //         );
                //       }:
                //           () async{
                //         generateotp = true;
                //         if (EmailValidator.validate(email)) {
                //           NetworkHandlerSignupOTP getdata =
                //           NetworkHandlerSignupOTP();
                //           dynamic check = await getdata.getOtp(email, context);
                //           testotp = check;
                //           startTimer();
                //           print("Test otp dynamic $testotp");
                //         } else {
                //           ScaffoldMessenger.of(context).showSnackBar(
                //             const SnackBar(
                //               duration: Duration(milliseconds: 1000),
                //               backgroundColor: kPrimaryColor,
                //               content: Text(
                //                 // "Password is not matched and Email is not correct",
                //                 "Enter Correct Email",
                //                 style: TextStyle(
                //                     color: korangeColor,
                //                     fontWeight: FontWeight.bold,
                //                     fontFamily: fontfamily),
                //                 textAlign: TextAlign.center,
                //               ),
                //             ),
                //           );
                //         }
                //
                //         // ScaffoldMessenger.of(context).showSnackBar(
                //         //   const SnackBar(
                //         //     duration: Duration(milliseconds: 1000),
                //         //     backgroundColor: kPrimaryColor,
                //         //     content: Text(
                //         //       // "Password is not matched and Email is not correct",
                //         //       "OTP Sent",
                //         //       style: TextStyle(
                //         //           color: korangeColor,
                //         //           fontWeight: FontWeight.bold,
                //         //           fontFamily: fontfamily),
                //         //       textAlign: TextAlign.center,
                //         //     ),
                //         //   ),
                //         // );
                //       },
                //       child: Text(
                //         "Send OTP",
                //         style: TextStyle(
                //           color: kPrimaryColor,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                //Text("$_current"),
                // Container(
                //   margin: const EdgeInsets.symmetric(vertical: 5),
                //   padding:
                //   const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                //   width: size.width * 0.8,
                //   decoration: BoxDecoration(
                //     color: kPrimaryLightColor,
                //     borderRadius: BorderRadius.circular(29),
                //   ),
                //   child: TextField(
                //     keyboardType: TextInputType.number,
                //     textInputAction: TextInputAction.done,
                //     onChanged: (value) {
                //       if (value == '') {
                //         setState(() {
                //           checkverification = true;
                //         });
                //       } else {
                //         onetimep = int.parse(value);
                //         setState(() {
                //           checkverification = false;
                //         });
                //       }
                //     },
                //     cursorColor: kPrimaryColor,
                //     decoration: const InputDecoration(
                //       icon: Icon(
                //         Icons.password_outlined,
                //         color: kPrimaryColor,
                //       ),
                //       hintText: "One Time Password",
                //       border: InputBorder.none,
                //     ),
                //   ),
                // ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  width: size.width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: ElevatedButton(
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
                                    await getdata.checkemail(email, context);
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
                        "Send OTP",
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
//
// class MyStatefulWidget extends StatefulWidget {
//   const MyStatefulWidget({Key? key}) : super(key: key);
//
//   @override
//   State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
// }
//
// /// This is the private State class that goes with MyStatefulWidget.
// class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//   String dropdownValue = 'One';
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       value: dropdownValue,
//       icon: const Icon(Icons.arrow_downward),
//       iconSize: 24,
//       elevation: 16,
//       style: const TextStyle(color: Colors.deepPurple),
//       underline: Container(
//         height: 2,
//         color: Colors.deepPurpleAccent,
//       ),
//       onChanged: (String? newValue) {
//         setState(() {
//           dropdownValue = newValue!;
//         });
//       },
//       items: <String>['One', 'Two', 'Free', 'Four']
//           .map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
// }
