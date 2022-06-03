import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testing_app/constants.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'addatrip.dart';

class MakeATrip extends StatelessWidget {
  String userid;
  MakeATrip({
    Key? key,
    required this.userid
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MakeATripScreen(userid: this.userid,),
    );
  }
}

class MakeATripScreen extends StatefulWidget {

  String userid;
  MakeATripScreen({
    required this.userid,
    Key? key,
  }) : super(key: key);

  @override
  State createState() => MakeATripScreenState();
}

class MakeATripScreenState extends State<MakeATripScreen> {

  String? tripname;
  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        foregroundColor: korangeColor,
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  // backgroundColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18.0))),
                  contentPadding: EdgeInsets.only(top: 10.0),
                  content: Container(
                    width: size.width*0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Make a Trip",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 24.0,color: kPrimaryColor),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        // Divider(
                        //   color: Colors.grey,
                        //   height: 4.0,
                        // ),
                        Padding(
                          padding: EdgeInsets.only(left: 30.0, right: 30.0),
                          child: TextField(

                            cursorColor: kPrimaryColor,
                            decoration: InputDecoration(
                              hintText: "Trip Name",
                              border: InputBorder.none,
                              // hintStyle: TextStyle(color: Colors.redAccent)
                            ),
                            onChanged: (value){
                              tripname = value;
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage())),
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return AddNewTrip(name: tripname.toString(), userid: widget.userid,);
                                },
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 20.0, bottom: 12.0),
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(18.0),
                                  bottomRight: Radius.circular(18.0)),
                            ),
                            child: Text(
                              "Create Trip",
                              style: TextStyle(color: CupertinoColors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
        child: Icon(
          Icons.add
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text(
          "Itineraries",
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
      body:false? GestureDetector(
        onTap: (){
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  // backgroundColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18.0))),
                  contentPadding: EdgeInsets.only(top: 10.0),
                  content: Container(
                    width: size.width*0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Make a Trip",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 24.0,color: kPrimaryColor),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        // Divider(
                        //   color: Colors.grey,
                        //   height: 4.0,
                        // ),
                        Padding(
                          padding: EdgeInsets.only(left: 30.0, right: 30.0),
                          child: TextField(

                            cursorColor: kPrimaryColor,
                            decoration: InputDecoration(
                              hintText: "Trip Name",
                              border: InputBorder.none,
                                // hintStyle: TextStyle(color: Colors.redAccent)
                            ),
                            onChanged: (value){
                              tripname = value;
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage())),
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return AddNewTrip(name: tripname.toString(), userid: widget.userid,);
                                },
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 20.0, bottom: 12.0),
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(18.0),
                                  bottomRight: Radius.circular(18.0)),
                            ),
                            child: Text(
                              "Create Trip",
                              style: TextStyle(color: CupertinoColors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
        //     () {
        //   showDialog(
        //     context: context,
        //     builder: (BuildContext context) => openAlertBox(context),
        //   );
        // },
        child: Center(
          child: Icon(
            Icons.add_circle_outlined,
            color: korangeColor,
            size: size.height * 0.1,
          ),
        ),
      ):Container(
        child: ListView.builder(
          itemCount: 4,
            itemBuilder: (BuildContext context, int index){
              return Container(
                // color: korangeColor,
                // height: size.height * 0.3,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                      height: size.height * 0.18,
                      decoration: BoxDecoration(
                        color: korangeColor,
                        borderRadius: BorderRadius.circular(15)
                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25,top: 5,right: 30),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Trip Name",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                            ),),
                            Text("Date : Unknown",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: kPrimaryhotelcolor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600
                              ),),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
        ),
      ),
    );
  }

  Widget _buildPopupDialog(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return AlertDialog(
      title: const Text(
        'Trip Name',
        style: TextStyle(color: kPrimaryColor),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
              cursorColor: kPrimaryColor,
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  const BorderSide(color: kPrimaryColor, width: 2.0),
                ),
                border: OutlineInputBorder(
                  borderSide: new BorderSide(color: kPrimaryColor),
                ),
              )),
        ],
      ),
      actions: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          width: size.width * 0.8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text(
                "Create a Trip",
                style: const TextStyle(color: kPrimaryColor),
              ),
              style: ElevatedButton.styleFrom(
                primary: korangeColor,
                padding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(
                    color: kPrimaryColor,
                    fontSize: 14,
                    fontFamily: fontfamily,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ],
    );
  }

}
