import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/NetworkHandler/editprofile.dart';
import 'package:testing_app/constants.dart';
import 'package:testing_app/NetworkHandler/signuphandler.dart';

class EditProfileScreen extends StatelessWidget {
   String id;
  String name;
  String city;
  String address;
  String password;
  String status;

  EditProfileScreen(
      {Key? key,
      required this.id,
      required this.name,
      required this.city,
      required this.address,
      required this.password,
        required this.status

      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EditProfile(
        id: id,
        name: name,
        city:city,
        address:address,
        password:password,
        status: status,
      ),
    );
  }
}

class EditProfile extends StatefulWidget {
  String id;
  String name;
  String city;
  String address;
  String password;
  String status;
  EditProfile(
      {Key? key,
      required this.id,
      required this.name,
      required this.city,
      required this.address,
      required this.password,
        required this.status
      })
      : super(key: key);

  @override
  State createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  // bool suffixcheck = true;
  // void initState() {
  //   getdata();
  //   super.initState();
  //
  // }

  IconData iconvisibility = Icons.visibility;

  late dynamic name = widget.name;
  late dynamic address = widget.address;
  late dynamic city = widget.city;
  late dynamic password = widget.password;
  late dynamic status = widget.status;
  // final email;
   // CompletingRegistration({Key? key, required this.email});


  void getdata() async{
    NetworkHandlerEditProfile data = NetworkHandlerEditProfile();
    dynamic datadb = await data.getdata(widget.id,context,widget.status);
    var decodeData =datadb;

    setState(() {
      name = decodeData['biz_name'];
      city = decodeData['city'];
      address = decodeData['address'];
      password = decodeData['password'];
    });
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: kPrimaryColor),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: kPrimaryColor,
          ),
        ),
      ),
      body: SizedBox(
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
            // Positioned(
            //   top: size.height * 0.08,
            //   child: Image.asset(
            //     "assets/images/signupbackground1.png",
            //     width: size.width * 0.6,
            //   ),
            // ),
            Positioned(
              top: size.height * 0.02,
              child: const Text(
                ("Profile"),
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 60,
                  color: korangeColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.12),
              child: Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // ClipRRect(
                      //   borderRadius: BorderRadius.circular(100),
                      //   child: SvgPicture.asset(
                      //     "assets/icons/avatar.svg",
                      //     color: kPrimaryLightColor,
                      //   ),
                      // ),
                      // SizedBox(height: size.height * 0.05),
                      // SizedBox(height: size.height * 0.22),

                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 2),
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          color: kPrimaryLightColor,
                          borderRadius: BorderRadius.circular(29),
                        ),
                        child: TextField(
                          key: ValueKey("name"),
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            name = value;
                          },
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                            icon: const Icon(
                              Icons.person,
                              color: kPrimaryColor,
                            ),
                            hintText: name,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 2),
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          color: kPrimaryLightColor,
                          borderRadius: BorderRadius.circular(29),
                        ),
                        child: TextField(
                          key: ValueKey("address"),
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            address = value;
                          },
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                            icon: const Icon(
                              Icons.place,
                              color: kPrimaryColor,
                            ),
                            hintText: address,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 2),
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          color: kPrimaryLightColor,
                          borderRadius: BorderRadius.circular(29),
                        ),
                        child: TextField(
                          key: ValueKey("city"),
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            city = value;
                          },
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                            icon: const Icon(
                              Icons.location_city,
                              color: kPrimaryColor,
                            ),
                            hintText: city,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 2),
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          color: kPrimaryLightColor,
                          borderRadius: BorderRadius.circular(29),
                        ),
                        child: TextField(
                          key: ValueKey("password"),
                          obscureText: false,
                          textInputAction: TextInputAction.next,
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
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        width: size.width * 0.8,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: ElevatedButton(
                            onPressed: () {
                              NetworkHandlerEditProfile updatedata = NetworkHandlerEditProfile();
                              updatedata.updatedata(widget.id,status, name, city, address, password, context);
                            },
                            child: const Text(
                              "Update Profile",
                              style: const TextStyle(color: kPrimaryColor),
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
            ),
          ],
        ),
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
