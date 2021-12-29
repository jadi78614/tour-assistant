import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:testing_app/ExpenseTrack/expensestracks.dart';
import 'package:testing_app/Login/login_screen.dart';
import 'package:testing_app/NetworkHandler/editprofile.dart';
import 'package:testing_app/EditProfile/editprofile.dart';
import 'package:testing_app/Weather/screens/loading_screen.dart';
import 'package:testing_app/constants.dart';
import 'package:testing_app/currencyconverter/home.dart';

import '../weatherscreen.dart';

class TouristDashboardDrawer extends StatefulWidget {
  String stringid;
  String name;
  String password;
  String address;
  String city;
  String status;
  TouristDashboardDrawer(
      {Key? key,
      required this.stringid,
      required this.name,
      required this.password,
      required this.address,
      required this.city,
      required this.status})
      : super(key: key);

  @override
  State<TouristDashboardDrawer> createState() => _TouristDashboardDrawerState();
}

class _TouristDashboardDrawerState extends State<TouristDashboardDrawer> {
  late dynamic stringid = widget.stringid;
  late dynamic name = widget.name;
  late dynamic status = widget.status;
  late dynamic email;
  late dynamic city = widget.city;
  late dynamic address = widget.address;
  late dynamic password = widget.password;

  Future getdata() async {
    NetworkHandlerEditProfile data = NetworkHandlerEditProfile();
    dynamic datadb =
        await data.getdata(widget.stringid, context, widget.status);
    var decodeData = datadb;

    setState(() {
      name = decodeData['name'];
      city = decodeData['city'];
      address = decodeData['address'];
      password = decodeData['password'];
    });
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    Size size = MediaQuery.of(context).size;

    return Drawer(
      key: Key("Drawer"),
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(

            decoration: const BoxDecoration(
              color: kPrimaryColor,
            ),
            child: Column(
              children: [
                CircleAvatar(
                    radius: size.width * 0.06,
                    child: Icon(
                      Icons.person,
                      color: kPrimaryColor,
                      size: size.width * 0.08,
                    ),
                    backgroundColor: korangeColor),
                const Padding(
                  padding: EdgeInsets.zero,
                  child: Text(
                    'Welcome',
                    style: TextStyle(color: korangeColor, fontSize: 15),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.zero,
                  child: Text(
                    '${name}',
                    style: const TextStyle(color: korangeColor, fontSize: 15),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Future.delayed(Duration.zero, () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) {
                      //         // print("Email $email");
                      //         return EditProfileScreen(
                      //           id: widget.stringid,
                      //           name: name,
                      //           city: city,
                      //           status:status,
                      //           address: address,
                      //           password: password,
                      //         );
                      //       },
                      //     ),
                      //   );
                      // });

                      pushNewScreen(
                        context,
                        screen: EditProfileScreen(
                          id: widget.stringid,
                          name: name,
                          city: city,
                          status: status,
                          address: address,
                          password: password,
                        ),
                        withNavBar: true, // OPTIONAL VALUE. True by default.
                      );
                    },
                    child: Text("Edit Profile",
                    style: TextStyle(
                      color: kPrimaryLightColor
                    ),
                    ))
              ],
            ),
          ),
          Column(
            children: [
              ListTile(
                leading: Icon(Icons.home,color: kPrimaryColor),
                title: const Text(
                  'Home',
                  style: TextStyle(fontSize: 16,color: kPrimaryColor),
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              // ListTile(
              //   leading: Icon(Icons.thermostat_outlined,color: kPrimaryColor),
              //   title: const Text(
              //     'Weather',
              //     style: TextStyle(fontSize: 16,color: kPrimaryColor),
              //   ),
              //   onTap: () {
              //     // Update the state of the app
              //     // ...
              //     // Then close the drawer
              //     Navigator.pop(context);
              //     Future.delayed(Duration.zero, () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) {
              //             return LoadingScreen();
              //           },
              //         ),
              //       );
              //     });
              //     // Future.delayed(Duration.zero, () {
              //     //   Navigator.push(
              //     //     context,
              //     //     MaterialPageRoute(
              //     //       builder: (context) {
              //     //         // print("Email $email");
              //     //         return HomePage();
              //     //       },
              //     //     ),
              //     //   );
              //     // });
              //     // pushDynamicScreen(
              //     //   context,
              //     //   screen: const HomePage(),
              //     //   withNavBar: true,
              //     // );
              //
              //   },
              // ),
              ListTile(
                leading: Icon(Icons.payments_outlined,
                color: kPrimaryColor,),
                title: const Text(
                  'Track Expenses',
                  style: TextStyle(fontSize: 16,color: kPrimaryColor),
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer

                  Navigator.pop(context);
                  // Future.delayed(Duration.zero, () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) {
                  //         // print("Email $email");
                  //         return HomePage();
                  //       },
                  //     ),
                  //   );
                  // });
                  // pushDynamicScreen(
                  //   context,
                  //   screen: const HomePage(),
                  //   withNavBar: true,
                  // );
                  pushNewScreen(
                    context,
                    screen: TrackExpenses(
                      userid: widget.stringid,
                    ),
                    withNavBar: true, // OPTIONAL VALUE. True by default.
                  );
                },
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.dollarSign,color: kPrimaryColor,),
                title: const Text(
                  'Currency Converter',
                  style: TextStyle(fontSize: 16,color: kPrimaryColor),
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer

                  Navigator.pop(context);
                  pushNewScreen(
                    context,
                    screen: CurrencyConverterScreen(),
                    withNavBar: true, // OPTIONAL VALUE. True by default.
                  );
                  // Future.delayed(Duration.zero, () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) {
                  //         // print("Email $email");
                  //         return CurrencyConverterScreen();
                  //       },
                  //     ),
                  //   );
                  // });
                },
              ),
              ListTile(
                leading: Icon(Icons.logout,color: kPrimaryColor),
                title: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 16,color: kPrimaryColor),
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);

                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (Route<dynamic> route) => false);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
