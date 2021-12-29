import 'package:flutter/material.dart';
import 'constants.dart';
import 'Login/login_screen.dart';

void main() {
  runApp(const MyApp());
}

//
// SharedPreferences prefs = await SharedPreferences.getInstance();
// prefs?.setBool("isLoggedIn", true);
//
// Future<void> main() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   var status = prefs.getBool('isLoggedIn') ?? false;
//   print(status);
//   runApp(MaterialApp(home: status == true ? Login() : Home()));
// }
//





class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tour Assistance',
      theme: ThemeData(
        fontFamily: fontfamily,
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  @override
  State createState() => WidgetStateWelcome();
}

class WidgetStateWelcome extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background14.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SizedBox(
          height: size.height,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              // Positioned(
              //   top: 0,
              //   left: 0,
              //   child: Image.asset(
              //     "assets/images/main_top.png",
              //     width: size.width * 0.4,
              //   ),
              // ),
              // Positioned(
              //   bottom: -5,
              //   left: -5,
              //   child: Image.asset(
              //     "assets/images/main_bottom.png",
              //     width: size.width * 0.2,
              //   ),
              // ),
              Positioned(
                bottom: size.height * 0.02,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      ("Enjoy Every        "),
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 40,
                        color: korangeColor,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const Text(
                      ("Moment With Us "),
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 40,
                        color: kPrimaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    // const Text(
                    //   ("Tour Assistant"),
                    //   style: TextStyle(
                    //       fontWeight: FontWeight.w900,
                    //       fontSize: 40,
                    //       color: kPrimaryColor,
                    //   ),
                    //   textAlign: TextAlign.center,
                    // ),
                    SizedBox(height: size.height * 0.02),
                    // SvgPicture.asset(
                    //   "assets/icons/chat.svg",
                    //   height: size.height * 0.28,
                    //   width: size.height * 0.4,
                    // ),
                    //SizedBox(height: size.height * 0.05),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      width: size.width * 0.8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: ElevatedButton(
                          onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const LoginScreen();
                                  },
                                ),
                              );
                          },
                          child: const Text(
                            "Let's Get Started",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary:korangeColor,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 12),
                            textStyle: const TextStyle(
                                fontSize: 20,
                                fontFamily: fontfamily,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     Future.delayed(Duration.zero, () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) {
                    //             return const SignUpScreen();
                    //           },
                    //         ),
                    //       );
                    //     });
                    //   },
                    //   child: const Text(
                    //     ("Create an account"),
                    //     style: TextStyle(
                    //       decoration: TextDecoration.underline,
                    //       fontWeight: FontWeight.w100,
                    //       fontSize: 14,
                    //       color: Color(0xFF6E37A6),
                    //     ),
                    //     textAlign: TextAlign.center,
                    //   ),
                    // ),
                    // Container(
                    //   margin: const EdgeInsets.symmetric(vertical: 5),
                    //   width: size.width * 0.8,
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(30),
                    //     child: ElevatedButton(
                    //
                    //       onPressed: () {
                    //         Future.delayed(Duration.zero, () {
                    //           Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //               builder: (context) {
                    //                 return const SignUpScreen();
                    //               },
                    //             ),
                    //           );
                    //         });
                    //       },
                    //       child: const Text(
                    //         "SIGN UP",
                    //         style: TextStyle(color: Colors.black),
                    //       ),
                    //       style: ElevatedButton.styleFrom(
                    //         primary: kPrimaryLightColor,
                    //         padding: const EdgeInsets.symmetric(
                    //             horizontal: 30, vertical: 20),
                    //         textStyle: const TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 14,
                    //             fontFamily: fontfamily,
                    //             fontWeight: FontWeight.w700),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
