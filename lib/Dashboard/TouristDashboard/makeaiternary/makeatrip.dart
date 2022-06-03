import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testing_app/Dashboard/TourCompany/makeaiternary/tripdata.dart';
import 'package:testing_app/constants.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:http/http.dart' as http;
import 'addatrip.dart';
import 'editoldtrip.dart';

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

  getdatafromdb() async{
    TripData details = TripData();
    List<TripData> dbdata = await details.getdatafromDB(widget.userid);
    // print("Quardinates are :${dbdata.first.days![0].places![0].location.coordinates}");
    setState(() {
      this.details = dbdata;
      check = true;
    });

  }

  List<TripData> details=[];


  @override
  void initState() {
    getdatafromdb();
  }
bool check = false;

  // Widget progressindicator(){
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return Center(
  //         child: Container(
  //           width: 40,
  //           height: 40,
  //           child: CircularProgressIndicator(
  //             valueColor:AlwaysStoppedAnimation<Color>(kPrimaryhotelcolor),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  String? tripname;
  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      floatingActionButton: Visibility(
        visible: details.isNotEmpty?true:false,
        child: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          foregroundColor: CupertinoColors.white,
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
                                  style: TextStyle(fontSize: 24.0,color: korangeColor),
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
                            onTap: () async{
                              //Todo Here I am
                              TripData data = TripData(name: tripname,from_time: DateTime(0000),to_date: DateTime(0000),tc_id: widget.userid,days: [],to_time: DateTime(0000),from_date: DateTime(0000));

                              http.Response response = await http.post(
                                Uri.parse("http://$urlmongo/tourcompany/create/manualSchedule/${widget.userid}"),
                                body: json.encode(data.givejsonobject()),
                                headers: {'Content-type': 'application/json', 'Accept': 'application/json'},
                              );
                              // print("Data from Oldness:${json.encode(data.givejsonobject())}");
                              // print("Response is out side the link${response.body}");
                              if (response.statusCode == 200) {
                                // print("Response is inside the link${response.body} in the reponse status code");
                                Navigator.pop(context);

                                // setState(() {
                                //   widget.data.getdatafromDB(s);
                                // });
                                await getdatafromdb();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    duration: Duration(milliseconds: 1000),
                                    backgroundColor: kPrimarycontrasthotelcolor,
                                    content: Text(
                                      // "Password is not matched and Email is not correct",
                                      "Trip Added successfully",
                                      style: TextStyle(color: kPrimaryhotelcolor, fontWeight: FontWeight.bold, fontFamily: fontfamily),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              } else {
                                Navigator.pop(context);
                                // print("Response is inside the link${response.body} in the reponse status code");
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    duration: Duration(milliseconds: 1000),
                                    backgroundColor: kPrimarycontrasthotelcolor,
                                    content: Text(
                                      // "Password is not matched and Email is not correct",
                                      "Something Went Wrong",
                                      style: TextStyle(color: kPrimaryhotelcolor, fontWeight: FontWeight.bold, fontFamily: fontfamily),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              }
                              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage())),
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) {
                              //       return AddNewTrip(name: tripname.toString(), userid: widget.userid,);
                              //     },
                              //   ),
                              // );
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
      body:check==false? Center(
        child: Container(
          width: 50,
          height: 50,
          color: CupertinoColors.white,
          child: CircularProgressIndicator(
            backgroundColor: CupertinoColors.white,
            valueColor:AlwaysStoppedAnimation<Color>(kPrimarytourcompanycolor),
          ),
        ),
      ): details.isEmpty? GestureDetector(
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
                                style: TextStyle(fontSize: 24.0,color: korangeColor),
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
                          onTap: ()async{
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return Center(
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    child: CircularProgressIndicator(
                                      valueColor:AlwaysStoppedAnimation<Color>(CupertinoColors.black),
                                    ),
                                  ),
                                );
                              },
                            );
                            //Todo Here I am
                            TripData data = TripData(name: tripname,from_time: DateTime(0000),to_date: DateTime(0000),tc_id: widget.userid,days: [],to_time: DateTime(0000),from_date: DateTime(0000));

                            http.Response response = await http.post(
                              Uri.parse("http://$urlmongo/tourcompany/create/manualSchedule/${widget.userid}"),
                              body: json.encode(data.givejsonobject()),
                              headers: {'Content-type': 'application/json', 'Accept': 'application/json'},
                            );
                            // print("Data from Oldness:${json.encode(data.givejsonobject())}");
                            // print("Response is out side the link${response.body}");
                            if (response.statusCode == 200) {
                              // print("Response is inside the link${response.body} in the reponse status code");
                              Navigator.pop(context);
                              Navigator.pop(context);

                              // setState(() {
                              //   widget.data.getdatafromDB(s);
                              // });
                              await getdatafromdb();

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  duration: Duration(milliseconds: 1000),
                                  backgroundColor: kPrimarycontrasthotelcolor,
                                  content: Text(
                                    // "Password is not matched and Email is not correct",
                                    "Trip Added successfully",
                                    style: TextStyle(color: kPrimaryhotelcolor, fontWeight: FontWeight.bold, fontFamily: fontfamily),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            } else {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              // print("Response is inside the link${response.body} in the reponse status code");
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  duration: Duration(milliseconds: 1000),
                                  backgroundColor: kPrimarycontrasthotelcolor,
                                  content: Text(
                                    // "Password is not matched and Email is not correct",
                                    "Something Went Wrong",
                                    style: TextStyle(color: kPrimaryhotelcolor, fontWeight: FontWeight.bold, fontFamily: fontfamily),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            }
                            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage())),
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) {
                            //       return AddNewTrip(name: tripname.toString(), userid: widget.userid,);
                            //     },
                            //   ),
                            // );
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
          itemCount: details.length,
            itemBuilder: (BuildContext context, int index){
              Random random =Random();
              print("Data is ${details[index].givejsonobject()}");

              return InkWell(
                onTap: ()async{
                  // builder: (context) {
                  //   return AddNewTrip(name: tripname.toString(), userid: widget.userid,);
                  // },
                  await Navigator.push(context,
                  MaterialPageRoute(
                      builder:(context) {
                              return Edittrip(
                                userid: details[index].tc_id.toString(),
                                name: details[index].name.toString(),
                                datais: details[index],
                              );
                            })
                  );

                  getdatafromdb();

                },
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20,right: 20,top: 20),
                      height: size.height * 0.1,
                      decoration: BoxDecoration(
                        color: korangeColor,
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: AssetImage("assets/images/placeholderimage-${random.nextInt(3)+1}.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25,top: 5,right: 30),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(details[index].name.toString(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600
                            ),),
                            Text(details[index].from_date==DateTime.parse("2000-01-01 00:00:00.000Z")?" ":DateFormat('yyyy, MMM dd').format(DateTime.parse(details[index].from_date.toString())) ,
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
