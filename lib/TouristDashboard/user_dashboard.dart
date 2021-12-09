import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/bottomnavigationbar.dart';
import 'components/touristdashboardbody.dart';
import 'components/touristdashboarddrawer.dart';

class UserDashboard extends StatelessWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      drawer: TouristDashboardDrawer(),
      body: UserDashboardTourist(),
      bottomNavigationBar: const TouristBottomNavigation(),
    );
  }
}


