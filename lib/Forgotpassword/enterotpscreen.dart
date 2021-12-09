import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/constants.dart';
import 'package:testing_app/Signup/singupemailverification.dart';
import 'package:testing_app/TouristDashboard/user_dashboard.dart';
import 'package:testing_app/Forgotpassword/forgotpassword.dart';

class OtpEnterScreen extends StatelessWidget {
  const OtpEnterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OtpEnterScreenWidget(),
    );
  }
}

class OtpEnterScreenWidget extends StatefulWidget {
  @override
  State createState() => _MediaQueryWidgetStateLogin();
}

class _MediaQueryWidgetStateLogin extends State<OtpEnterScreenWidget> {
  bool suffixcheck = true;
  IconData iconvisibility = Icons.visibility;

  @override
  Widget build(BuildContext context) {
    final iskeyboardon = MediaQuery.of(context).viewInsets.bottom != 0;

    //print("Key board check $iskeyboardon");
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
          //     "assets/images/main_top.png",
          //     width: size.width * 0.35,
          //   ),
          //   top: 0,
          //   left: 0,
          // ),
          Positioned(
            child: Image.asset(
              "assets/images/login_bottom.png",
              width: size.width * 0.4,
            ),
            bottom: 0,
            right: 0,
          ),
          if (!iskeyboardon) buildLogo(size),

          // Positioned(
          //   bottom: size.height * 0.6,
          //   child: const Text(
          //     ("Login "),
          //     style: TextStyle(
          //       fontWeight: FontWeight.w900,
          //       fontSize: 70,
          //       color: korangeColor,
          //     ),
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // const Text(
                //   ("Login "),
                //   style: TextStyle(
                //     fontWeight: FontWeight.w900,
                //     fontSize: 40,
                //     color: kPrimaryColor,
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                SizedBox(height: size.height * 0.22),
                const Text(
                  ("Verification "),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 60,
                    color: korangeColor,
                  ),
                  textAlign: TextAlign.center,
                ),

                // ClipRRect(
                //   borderRadius: BorderRadius.circular(100),
                //   child: SvgPicture.asset(
                //     "assets/icons/avatar.svg",
                //     color: kPrimaryLightColor,
                //   ),
                // ),
                SizedBox(height: size.height * 0.02),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    color: kPrimaryLightColor,
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: TextField(
                    onChanged: (value) {},
                    cursorColor: kPrimaryColor,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: kPrimaryColor,
                      ),
                      hintText: "Username or Email",
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
                    obscureText: suffixcheck,
                    onChanged: (value) {},
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

                Padding(
                  padding: EdgeInsets.only(right: size.width * 0.14),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Future.delayed(Duration.zero, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const FogotPassword();
                              },
                            ),
                          );
                        });
                      },
                      child: const Text(
                        "Forgot password ?",
                        textAlign: TextAlign.right,
                        style: TextStyle(color: kPrimaryColor),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  width: size.width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: ElevatedButton(
                      onPressed: () {
                        Future.delayed(
                          Duration.zero,
                              () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const UserDashboard();
                                },
                              ),
                            );
                          },
                        );
                      },
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(color: kPrimaryLightColor),
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
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "Don't have an Account ? ",
                        style: TextStyle(color: kPrimaryColor),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Future.delayed(
                            Duration.zero,
                                () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return SignUpVerification();
                                  },
                                ),
                              );
                            },
                          );
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: korangeColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Positioned buildLogo(Size size) {
    return Positioned(
      top: size.height * 0.08,
      child: Image.asset(
        "assets/images/loginbackground.png",
        width: size.width * 0.55,
      ),
    );
  }
}
