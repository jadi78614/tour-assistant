import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:testing_app/Dashboard/TourCompany/makeaiternary/tripdata.dart';
import 'package:testing_app/constants.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:http/http.dart' as http;

class EditTripDetails extends StatelessWidget {
  String name;
  TripData data;
  EditTripDetails({Key? key, required this.name, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EditTripDetailsScreen(
        name: this.name,
        data: this.data,
      ),
    );
  }
}

class EditTripDetailsScreen extends StatefulWidget {
  String name;
  TripData data;
  EditTripDetailsScreen({
    Key? key,
    required this.name,
    required this.data,
  }) : super(key: key);

  @override
  State createState() => EditTripDetailsScreenState();
}

class EditTripDetailsScreenState extends State<EditTripDetailsScreen> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titlecontroller.text = widget.name.toString();
    name = titlecontroller.text;
    // descriptioncontroller.text = widget.data.
  }

  var lengthdescription;
  var countingchars = "0";
  bool descriptionkeyboard = false;
String name = "";
  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          "Edit Trip Details",
          style: TextStyle(color: kPrimaryColor),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context,name);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: kPrimaryColor,
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          // Container(
          //   height: size.height * 0.2,
          //     decoration: BoxDecoration(
          //       image: DecorationImage(
          //         image: AssetImage("assets/images/tripdetails-01.png"),
          //         fit: BoxFit.cover
          //       ),
          //     ),
          //   ),
          Positioned(
            top: 0,
            child: Container(
              height: size.height * 0.25,
              width: size.width,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/tripdetails-09.png"), fit: BoxFit.cover),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
              ),
              // child: ClipRRect(
              //   child: Image(
              //     image: AssetImage("assets/images/tripdetails-03.png"),
              //     fit: BoxFit.cover,
              //   ),
              // ),
            ),
          ),
          // Positioned(
          //   top: 25,
          //   left: 0,
          //   width: MediaQuery.of(context).size.width,
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: <Widget>[
          //         IconButton(
          //           icon: Icon(
          //             Icons.arrow_back_ios_new,
          //             color: kPrimaryColor,
          //             // size: 30,
          //           ),
          //           onPressed: () => Navigator.pop(context),
          //         ),
          //         Text(
          //           "Edit Trip Details",
          //           style: TextStyle(color: kPrimaryColor, fontSize: 20),
          //         )
          //         // Icon(
          //         //   Icons.bookmark_border,
          //         //   color: Colors.white,
          //         //   size: 30,
          //         // )
          //       ],
          //     ),
          //   ),
          // ),
          // Positioned(
          //   top: size.height * 0.42,
          //   child: Text(
          //     ("Edit Trip"),
          //     style: TextStyle(
          //       fontWeight: FontWeight.w900,
          //       fontSize: 60,
          //       color: korangeColor,
          //     ),
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          Positioned(
            top: size.height * 0.26,
            left: size.width * 0.12,
            child: Text(
              "Title",
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.normal,
                fontSize: 15.0,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Positioned(
            top: size.height * 0.28,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
              width: size.width * 0.8,
              decoration: BoxDecoration(
                color: Color(0xFFF2F3F8),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                onChanged: (value){
                  name = value;
                },
                controller: titlecontroller,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          // Positioned(
          //   top: size.height * 0.36,
          //   left: size.width * 0.12,
          //   child: Text(
          //     "Description",
          //     style: TextStyle(
          //       color: kPrimaryColor,
          //       fontWeight: FontWeight.normal,
          //       fontSize: 15.0,
          //     ),
          //   ),
          // ),
          //
          // Positioned(
          //   top: size.height * 0.38,
          //   child: Container(
          //     margin: const EdgeInsets.only(top: 5, bottom: 10),
          //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
          //     width: size.width * 0.8,
          //     decoration: BoxDecoration(
          //       color: Color(0xFFF2F3F8),
          //       borderRadius: BorderRadius.circular(15),
          //     ),
          //     child: TextField(
          //       inputFormatters: [LengthLimitingTextInputFormatter(160)],
          //       // maxLength: 160,
          //       // maxLengthEnforcement:MaxLengthEnforcement() ,
          //       // readOnly:descriptionkeyboard ,
          //       controller: descriptioncontroller,
          //       onChanged: (value) {
          //         lengthdescription = value;
          //         setState(() {
          //           countingchars = lengthdescription.length.toString();
          //           // if(countingchars.length == 160){
          //           //   // descriptionkeyboard = true;
          //           // }
          //         });
          //       },
          //       keyboardType: TextInputType.multiline,
          //       maxLines: 4,
          //       textInputAction: TextInputAction.newline,
          //       cursorColor: kPrimaryColor,
          //       decoration: InputDecoration(
          //         border: InputBorder.none,
          //       ),
          //     ),
          //   ),
          // ),
          // Positioned(
          //   top: size.height * 0.515,
          //   right: size.width * 0.105,
          //   child: Text(
          //     "$countingchars/160 max",
          //     style: TextStyle(
          //       color: kPrimaryColor,
          //       fontWeight: FontWeight.normal,
          //       fontSize: 10.0,
          //     ),
          //   ),
          // ),
          Positioned(
            top: size.height * 0.36,

            // top: size.height * 0.5355,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              width: size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: ElevatedButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Center(
                          child: Container(
                            width: 40,
                            height: 40,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(kPrimarytourcompanycolor),
                            ),
                          ),
                        );
                      },
                    );
                    // widget.data.name= name;

                    http.Response response = await http.put(
                      Uri.parse("http://$urlmongo/tourcompany/update/manualSchedule/${widget.data.tripid}"),
                      body: json.encode({"name":name}),
                      headers: {'Content-type': 'application/json', 'Accept': 'application/json'},
                    );
                    print("Response.body is ${json.encode(widget.data.givejsonobject())}");
                    print("http://$urlmongo/tourcompany/update/manualSchedule/${widget.data.tripid}");
                    if (response.statusCode == 200) {
                      // Navigator.pop(context);
                      Navigator.pop(context);
                      // detailsResult = DetailsResult();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 1000),
                          backgroundColor: kPrimarycontrasthotelcolor,
                          content: Text(
                            // "Password is not matched and Email is not correct",
                            "Trip Updated successfully",
                            style: TextStyle(color: kPrimaryhotelcolor, fontWeight: FontWeight.bold, fontFamily: fontfamily),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    } else {
                      Navigator.pop(context);
                      // print(
                      // "Response is inside the link${response.body} in the reponse status code");
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
                    // setState(() {
                    //   widget.data.from_date;
                    // });
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(color: kPrimaryColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: korangeColor,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: const TextStyle(color: kPrimaryColor, fontSize: 14, fontFamily: fontfamily, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              width: size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: ElevatedButton(
                  onPressed: () async {
                    // http://apitourassistant.herokuapp.com/tourcompany/update/manualSchedule/628542cbe38e14d4913a3138

                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Center(
                          child: Container(
                            width: 40,
                            height: 40,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(kPrimarytourcompanycolor),
                            ),
                          ),
                        );
                      },
                    );

                    http.Response response = await http.delete(
                      Uri.parse("http://$urlmongo/tourcompany/delete/manualSchedule/${widget.data.tripid}"),
                    );
                    if (response.statusCode == 200) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 1000),
                          backgroundColor: kPrimarycontrasthotelcolor,
                          content: Text(
                            "Trip Deleted successfully",
                            style: TextStyle(color: kPrimaryhotelcolor, fontWeight: FontWeight.bold, fontFamily: fontfamily),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    } else {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 1000),
                          backgroundColor: kPrimarycontrasthotelcolor,
                          content: Text(
                            "Something Went Wrong",
                            style: TextStyle(color: kPrimaryhotelcolor, fontWeight: FontWeight.bold, fontFamily: fontfamily),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    "Delete This Trip",
                    style: TextStyle(color: korangeColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: const TextStyle(color: kPrimaryColor, fontSize: 14, fontFamily: fontfamily, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
