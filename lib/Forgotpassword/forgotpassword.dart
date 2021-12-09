
import 'package:flutter/material.dart';
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
  List<String> listitems = [
    'Tourist',
    'Tour Company',
    'Driver',
    'Tour Guide',
    'Hotel'
  ];
  String name="";
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
          // Positioned(
          //   child: Image.asset(
          //     "assets/images/main_bottom.png",
          //     width: size.width * 0.3,
          //   ),
          //   bottom: -60,
          //   left: 0,
          // ),
          Positioned(
            top: size.height * 0.08,
            child: Image.asset(
              "assets/images/resetpassword.png",
              width: size.width * 0.6,
            ),
          ),
          Positioned(
            top: size.height * 0.25,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: size.height * 0.05),
                  const Text(
                    ("Reset "),
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 60,
                      color: korangeColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    ("Password "),
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
                    const EdgeInsets.only(left:20,top: 2,bottom: 2,right: 3),
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
                      decoration:const InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: kPrimaryColor,
                        ),
                        hintText: "Enter Your Email",
                        border: InputBorder.none,
                        // suffixIcon: ClipRRect(
                        //   borderRadius: BorderRadius.circular(30),
                        //   child: ElevatedButton(
                        //     onPressed: () {
                        //       if (password != password2 ) {
                        //         ScaffoldMessenger.of(context).showSnackBar(
                        //           const SnackBar(
                        //             duration: Duration(milliseconds: 1000),
                        //             backgroundColor: kPrimaryColor,
                        //             content: Text(
                        //               // "Password is not matched and Email is not correct",
                        //               "OTP Sent",
                        //               style:  TextStyle(
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
                        //       style: TextStyle(color: kPrimaryColor),
                        //     ),
                        //     style: ElevatedButton.styleFrom(
                        //       primary: korangeColor,
                        //
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
                  //     textInputAction: TextInputAction.next,
                  //     onChanged: (value) {
                  //       name = value;
                  //     },
                  //     cursorColor: kPrimaryColor,
                  //     decoration: const InputDecoration(
                  //       icon: Icon(
                  //         Icons.password_outlined,
                  //         color: kPrimaryColor,
                  //       ),
                  //       hintText: "Enter OTP",
                  //       border: InputBorder.none,
                  //     ),
                  //   ),
                  // ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    width: size.width * 0.8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: ElevatedButton(
                        onPressed: () {
                          Future.delayed(Duration.zero, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const OtpEnterScreen();
                                },
                              ),
                            );
                          });
                        },
                        child: const Text(
                          "Send OTP",
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
