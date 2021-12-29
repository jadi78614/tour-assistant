import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/NetworkHandler/forgotpassword.dart';
import 'package:testing_app/NetworkHandler/signuphandler.dart';
import 'package:testing_app/constants.dart';

class EnterPassword extends StatelessWidget {
  final email;
  const EnterPassword({Key? key,
  required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EnterPasswordWidget(email: email,),
    );
  }
}

class EnterPasswordWidget extends StatefulWidget {

  final email;

  const EnterPasswordWidget({Key? key, this.email}) : super(key: key);

  @override
  State createState() => _MediaQueryWidgetStateLogin();
}

class _MediaQueryWidgetStateLogin extends State<EnterPasswordWidget> {
  bool suffixcheck = true;
  IconData iconvisibility = Icons.visibility;
  List<String> listitems = [
    'Tourist',
    'Tour Company',
    'Driver',
    'Tour Guide',
    'Hotel'
  ];
  String name = "";
  String? password;
  String? password2;
  String? dropdownValue;
  // final email;
  //  CompletingRegistration({Key? key, required this.email});

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
          //     "assets/images/signupbackground1.png",
          //     width: size.width * 0.6,
          //   ),
          // ),
          Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: size.height * 0.22),
                  //Text(widget.email),
                  const Text(
                    ("Enter New Password "),
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

                  // Container(
                  //   margin: const EdgeInsets.symmetric(vertical: 5),
                  //   padding:
                  //       const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                  //   width: size.width * 0.8,
                  //   decoration: BoxDecoration(
                  //     color: kPrimaryLightColor,
                  //     borderRadius: BorderRadius.circular(29),
                  //   ),
                  //   child: TextField(
                  //     textInputAction: TextInputAction.next,
                  //     onChanged: (value) {
                  //       name = value;
                  //     },
                  //     cursorColor: kPrimaryColor,
                  //     decoration: const InputDecoration(
                  //       icon: Icon(
                  //         Icons.fingerprint_outlined,
                  //         color: kPrimaryColor,
                  //       ),
                  //       hintText: "Username",
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
                      textInputAction: TextInputAction.next,
                      obscureText: suffixcheck,
                      onChanged: (value) {
                        password = value;
                      },
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        icon: const Icon(
                          Icons.lock,
                          color: kPrimaryColor,
                        ),
                        hintText: "Password",
                        border: InputBorder.none,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (suffixcheck == true) {
                                iconvisibility = Icons.visibility_off;
                                suffixcheck = false;
                              } else {
                                suffixcheck = true;
                                iconvisibility = Icons.visibility;
                              }
                              // suffixcheck=true? suffixcheck =false:suffixcheck=true;
                            });
                          },
                          child: Icon(
                            iconvisibility,
                            color: korangeColor,
                          ),
                        ),
                      ),
                    ),
                  ),
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
                      textInputAction: TextInputAction.done,
                      onSubmitted: (value) {
                        if (password != value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: kPrimaryColor,
                              content: Text(
                                // "Password is not matched and Email is not correct",
                                (password != value)
                                    ? "Password is not matched "
                                    : "Email is not correct",
                                style: const TextStyle(
                                    color: korangeColor,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: fontfamily),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }
                      },
                      obscureText: suffixcheck,
                      onChanged: (value) {
                        password2 = value;
                      },
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        icon: const Icon(
                          Icons.lock,
                          color: kPrimaryColor,
                        ),
                        hintText: "Re Enter Password",
                        border: InputBorder.none,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (suffixcheck == true) {
                                iconvisibility = Icons.visibility_off;
                                suffixcheck = false;
                              } else {
                                suffixcheck = true;
                                iconvisibility = Icons.visibility;
                              }
                              // suffixcheck=true? suffixcheck =false:suffixcheck=true;
                            });
                          },
                          child: Icon(
                            iconvisibility,
                            color: korangeColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    width: size.width * 0.8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: ElevatedButton(
                        onPressed: () {
                          if (password != password2) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(milliseconds: 1000),
                                backgroundColor: kPrimaryColor,
                                content: Text(
                                  // "Password is not matched and Email is not correct",
                                  "Password is not matched",
                                  style: TextStyle(
                                      color: korangeColor,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: fontfamily),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }else{
                            print("Press print");
                            NetworkHandlerForgotPassword changepassword = NetworkHandlerForgotPassword();
                            changepassword.savenewpassword(widget.email,context,password);
                            print("Press print");

                          }
                        },
                        child: const Text(
                          "Reset Password",
                          style: TextStyle(color: kPrimaryColor),
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
        ],
      ),
    );
  }
}
