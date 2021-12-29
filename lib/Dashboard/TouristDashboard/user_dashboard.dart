import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:testing_app/NetworkHandler/editprofile.dart';
import 'components/bottomnavigationbar.dart';
import 'components/touristdashboarddrawer.dart';
final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
class UserDashboard extends StatefulWidget {
  dynamic stringid;
  dynamic name;
  dynamic status;
  dynamic email;
  dynamic city;
  dynamic address;
  dynamic password;
  UserDashboard({
    Key? key,
    required this.name,
    required this.stringid,
    required this.status,
    required this.email,
    required this.city,
    required this.address,
    required this.password,
  }) : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {

  @override
  void initState(){
    super.initState();
    _determinePosition();
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future getdata() async{
    NetworkHandlerEditProfile data = NetworkHandlerEditProfile();
    dynamic datadb = await data.getdata(widget.stringid,context,widget.status);
    var decodeData =datadb;

    setState(() {
      widget.name = decodeData['name'];
      widget.city = decodeData['city'];
      widget.address = decodeData['address'];
      widget.password = decodeData['password'];
    });
  }

  @override
  Widget build(BuildContext context) {
    getdata();
    return Scaffold(
      // appBar: AppBar(
      //   shadowColor: Colors.transparent,
      //   title: const Text(
      //     "Dashboard",
      //     style: TextStyle(
      //       color: Colors.white,
      //     ),
      //   ),
      //   backgroundColor: Colors.transparent,
      //   // actions: <Widget>[
      //   //   Padding(
      //   //     padding: const EdgeInsets.only(right: 20.0),
      //   //     child: GestureDetector(
      //   //       onTap: () {},
      //   //       child: const Icon(
      //   //         Icons.account_circle,
      //   //         size: 30.0,
      //   //       ),
      //   //     ),
      //   //   ),
      //   // ],
      //   leading: Builder(
      //     builder: (context) {
      //       return IconButton(
      //         icon:const Icon(
      //           Icons.menu_outlined,
      //         color: kPrimaryColor,),
      //         onPressed: () {
      //           Scaffold.of(context).openDrawer();
      //         },
      //       );
      //     }
      //   ),
      //
      // ),
      drawer: TouristDashboardDrawer(
        stringid: widget.stringid,
        name: widget.name,
        city: widget.city,
        address: widget.address,
        status:widget.status,
        password: widget.password
      ),

      //UserDashboardTourist(),
      bottomNavigationBar: TouristBottomNavigation(stringid:widget.stringid),
    );
  }
//
//   Widget _buildOffstageNavigator(TabItem tabItem) {
//     return Offstage(
//       offstage: _currentTab != tabItem,
//       child: TabNavigator(
//         navigatorKey: _navigatorKeys[tabItem],
//         tabItem: tabItem,
//       ),
//     );
//   }
// }
// void main() => runApp(MyApp());
//
// BuildContext testContext;
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Persistent Bottom Navigation Bar example project',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MainMenu(),
//       initialRoute: '/',
//       routes: {
//         // When navigating to the "/" route, build the FirstScreen widget.
//         '/first': (context) => MainScreen2(),
//         // When navigating to the "/second" route, build the SecondScreen widget.
//         '/second': (context) => MainScreen3(),
//       },
//     );
//   }
// }
// import 'package:testing_app/Dashboard/TouristDashboard/components/touristdashboardbody.dart';
// import 'user_booking.dart';
// import 'user_search.dart';
// import 'user_wishlist.dart';
// import 'user_chat.dart';
//
//
// class UserDashboard extends StatefulWidget {
//   UserDashboard({Key? key}) : super(key: key);
//
//   @override
//   _MainMenuState createState() => _MainMenuState();
// }
//
// class _MainMenuState extends State<UserDashboard> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Center(
//             child: ElevatedButton(
//               child: Text("Built-in styles example"),
//               onPressed: () => pushNewScreen(
//                 context,
//                 screen: ProvidedStylesExample(
//                   menuScreenContext: context,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
}