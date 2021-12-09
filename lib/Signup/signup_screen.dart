import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/TouristDashboard/user_dashboard.dart';
import 'package:testing_app/constants.dart';
import 'package:testing_app/Login/login_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:email_validator/email_validator.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _MediaQueryWidgetSignUp(),
    );
  }
}

class _MediaQueryWidgetSignUp extends StatefulWidget {
  @override
  State createState() => _MediaQueryWidgetStateSignUp();
}

class _MediaQueryWidgetStateSignUp extends State<_MediaQueryWidgetSignUp> {
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
                  const Text(
                    ("Profile "),
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
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(29),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(right: size.width * 0.034),
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        borderRadius: BorderRadius.circular(20),
                        isExpanded: true,
                        icon: const Icon(
                          Icons.arrow_drop_down_circle,
                          color: korangeColor,
                        ),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: kPrimaryColor),
                        underline: Container(
                          height: 2,
                          color: Colors.transparent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: listitems
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Row(
                              // ['Select Type','Tourist', 'Tour Company', 'Drivers', 'Tour Guides','Hotels'];
                              children: [
                                if (value == listitems[0])
                                  const Icon(
                                    Icons.hiking,
                                    color: korangeColor,
                                  ),
                                if (value == listitems[1])
                                  const Icon(
                                    Icons.backpack,
                                    color: korangeColor,
                                  ),
                                if (value == listitems[2])
                                  const Icon(
                                    Icons.time_to_leave,
                                    color: korangeColor,
                                  ),
                                if (value == listitems[3])
                                  const Icon(
                                    Icons.face,
                                    color: korangeColor,
                                  ),
                                if (value == listitems[4])
                                  const Icon(
                                    Icons.hotel,
                                    color: korangeColor,
                                  ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: size.width * 0.04),
                                  child: Text(
                                    value,
                                    textAlign: TextAlign.left,
                                    style:
                                        const TextStyle(fontFamily: fontfamily),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        hint: Row(
                          children: [
                            const Icon(Icons.drag_indicator),
                            Padding(
                              padding: EdgeInsets.only(
                                left: size.width * 0.05,
                              ),
                              child: Text(
                                "Who are you?",
                                style: TextStyle(
                                  color: Colors.black54.withOpacity(0.6),
                                  fontFamily: fontfamily,
                                  fontSize: size.width * 0.038,
                                ),
                              ),
                            ),
                          ],
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
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        name = value;
                      },
                      cursorColor: kPrimaryColor,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: kPrimaryColor,
                        ),
                        hintText: "Name",
                        border: InputBorder.none,
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
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        name = value;
                      },
                      cursorColor: kPrimaryColor,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.fingerprint_outlined,
                          color: kPrimaryColor,
                        ),
                        hintText: "Username",
                        border: InputBorder.none,
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
                                    :"Email is not correct",
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
                          if (password != password2 ) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(milliseconds: 1000),
                                backgroundColor: kPrimaryColor,
                                content: Text(
                                  // "Password is not matched and Email is not correct",
                                  "Password is not matched",
                                  style:  TextStyle(
                                      color: korangeColor,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: fontfamily),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          } else {
                            Future.delayed(Duration.zero, () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const UserDashboard();
                                  },
                                ),
                              );
                            });
                          }
                        },
                        child: const Text(
                          "Complete Registration",
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
