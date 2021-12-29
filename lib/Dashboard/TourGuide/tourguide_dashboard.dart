import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/NetworkHandler/editprofile.dart';
import 'components/bottomnavigationbar.dart';
import 'components/touristdashboardbody.dart';
import 'components/touristdashboarddrawer.dart';

class TourGuideDashboard extends StatefulWidget {
  dynamic stringid;
  dynamic name;
  dynamic status;
  dynamic email;
  dynamic city;
  dynamic address;
  dynamic password;
  TourGuideDashboard({Key? key,
    required this.name,
    required this.stringid,
    required this.status,
    required this.email,
    required this.city,
    required this.address,
    required this.password,
  }) : super(key: key);

  @override
  State<TourGuideDashboard> createState() => _TourGuideDashboardState();
}

class _TourGuideDashboardState extends State<TourGuideDashboard> {
  Future getdata() async{
    NetworkHandlerEditProfile data = NetworkHandlerEditProfile();
    dynamic datadb = await data.getdata(widget.stringid,context,widget.status);
    var decodeData =datadb;
    print("Data $decodeData");

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
      drawer: TourGuideDashboardDrawer(
          stringid: widget.stringid,
          name: widget.name,
          city: widget.city,
          address: widget.address,
          status:widget.status,
          password: widget.password
      ),
      body: UserDashboardTourGuide(),
      bottomNavigationBar: const TourGuideBottomNavigation(),
    );
  }
}


