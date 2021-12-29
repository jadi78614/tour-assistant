import 'package:flutter/material.dart';
import 'package:testing_app/EditProfile/editprofile.dart';
import 'package:testing_app/Login/login_screen.dart';
import 'package:testing_app/NetworkHandler/editprofile.dart';
import 'package:testing_app/constants.dart';

class TourGuideDashboardDrawer extends StatefulWidget {
  String stringid;
  String name;
  String password;
  String address;
  String city;
  String status;
  TourGuideDashboardDrawer({
    Key? key,
    required this.stringid,
    required this.name,
    required this.password,
    required this.address,
    required this.city,
    required this.status
  }) : super(key: key);

  @override
  State<TourGuideDashboardDrawer> createState() => _TourGuideDashboardDrawerState();
}

class _TourGuideDashboardDrawerState extends State<TourGuideDashboardDrawer> {

  late dynamic stringid = widget.stringid;
  late dynamic  name=widget.name;
  late dynamic status = widget.status ;
  late dynamic email;
  late dynamic city = widget.city;
  late dynamic address = widget.address;
  late dynamic password = widget.password;


  Future getdata() async{
    NetworkHandlerEditProfile data = NetworkHandlerEditProfile();
    dynamic datadb = await data.getdata(widget.stringid,context,widget.status);
    var decodeData =datadb;
    print("Data $decodeData");

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
                    style:  TextStyle(
                        color: korangeColor,
                        fontSize: 15),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.zero,
                  child: Text(
                    '${name}',
                    style: const TextStyle(
                        color: korangeColor,
                        fontSize: 15),
                  ),
                ),                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Future.delayed(Duration.zero, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              // print("Email $email");
                              return EditProfileScreen(
                                id: widget.stringid,
                                name: name,
                                city: city,
                                status:status,
                                address: address,
                                password: password,
                              );
                            },
                          ),
                        );
                      });
                    },
                    child: Text("Edit Profile"))
              ],
            ),
          ),
          Column(
            children: [
              ListTile(
                leading: Icon(Icons.home),
                title: const Text(
                  'Home',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: const Text(
                  'Settings',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer

                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 20),
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