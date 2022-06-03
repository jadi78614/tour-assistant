import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:testing_app/constants.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class EditTripDetails extends StatelessWidget {
  String name;
  EditTripDetails({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EditTripDetailsScreen(
        name: this.name,
      ),
    );
  }
}

class EditTripDetailsScreen extends StatefulWidget {
  String name;
  EditTripDetailsScreen({
    Key? key,
    required this.name,
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
  }

  var lengthdescription;
  var countingchars = "0";
  bool descriptionkeyboard = false;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   shadowColor: Colors.transparent,
      //   title: Text(
      //     "",
      //     style: TextStyle(color: kPrimaryColor),
      //   ),
      //   leading: GestureDetector(
      //     onTap: () {
      //       Navigator.pop(context);
      //     },
      //     child: const Icon(
      //       Icons.arrow_back_ios_new,
      //       color: kPrimaryColor,
      //     ),
      //   ),
      // ),
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
          Positioned(
            top: 25,
            left: 0,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: kPrimaryColor,
                      // size: 30,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    "Edit Trip Details",
                    style: TextStyle(color: kPrimaryColor, fontSize: 20),
                  )
                  // Icon(
                  //   Icons.bookmark_border,
                  //   color: Colors.white,
                  //   size: 30,
                  // )
                ],
              ),
            ),
          ),
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
                controller: titlecontroller,
                textInputAction: TextInputAction.next,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.36,
            left: size.width * 0.12,
            child: Text(
              "Description",
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.normal,
                fontSize: 15.0,
              ),
            ),
          ),

          Positioned(
            top: size.height * 0.38,
            child: Container(
              margin: const EdgeInsets.only(top: 5, bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
              width: size.width * 0.8,
              decoration: BoxDecoration(
                color: Color(0xFFF2F3F8),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                inputFormatters: [LengthLimitingTextInputFormatter(160)],
                // maxLength: 160,
                // maxLengthEnforcement:MaxLengthEnforcement() ,
                // readOnly:descriptionkeyboard ,
                controller: descriptioncontroller,
                onChanged: (value) {
                  lengthdescription = value;
                  setState(() {
                    countingchars = lengthdescription.length.toString();
                    // if(countingchars.length == 160){
                    //   // descriptionkeyboard = true;
                    // }
                  });
                },
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                textInputAction: TextInputAction.newline,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.515,
            right: size.width * 0.105,
            child: Text(
              "$countingchars/160 max",
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.normal,
                fontSize: 10.0,
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.5355,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              width: size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Delete This Trip",
                    style: TextStyle(color: korangeColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: const TextStyle(
                        color: kPrimaryColor, fontSize: 14, fontFamily: fontfamily, fontWeight: FontWeight.w500),
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
                  onPressed: () {},
                  child: const Text(
                    "Save",
                    style: TextStyle(color: kPrimaryColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: korangeColor,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: const TextStyle(
                        color: kPrimaryColor, fontSize: 14, fontFamily: fontfamily, fontWeight: FontWeight.w500),
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
