import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:testing_app/Weather/services/networking.dart';
import 'package:testing_app/Weather/services/weather.dart';
import 'package:testing_app/Weather/utilities/constants.dart';
import 'package:testing_app/constants.dart';

class DetailsPageBottomSheet extends StatefulWidget {
  // late final locationWeather;
  final String placeId;
  final GooglePlace googlePlace;
  final Function? ontap;

  DetailsPageBottomSheet({Key? key, required this.placeId, required this.googlePlace, this.ontap})
      : super(key: key);

  @override
  _DetailsPageBottomSheetState createState() =>
      _DetailsPageBottomSheetState(this.placeId, this.googlePlace,this.ontap);
}

class _DetailsPageBottomSheetState extends State<DetailsPageBottomSheet> {
  // Future<dynamic> getLocationWeather() async {
  //   var late = detailsResult.geometry!.location!.lat;
  //   var long = detailsResult.geometry!.location!.lng;
  //
  //   print("Latitude is $late and longitude is $long");
  //
  //   var data = NetworkHelper(
  //     "$kOwmUrl?lat=${detailsResult.geometry!.location!.lat}&lon=${detailsResult.geometry!.location!.lng}",
  //   ).getData();
  //
  //   print("DATA is $data");
  //
  //   return data;
  // }
  WeatherModel model = WeatherModel();
  late int temp = 0;
  late var wind = 0.0;
  late var humidity = 0;
  late String city = '', weatherIcon = '0';
  dynamic data;
  late final String placeId;
  late final GooglePlace googlePlace;
  late final List<GooglePlace> selectedplaces= [];

  var ontap;
  _DetailsPageBottomSheetState(this.placeId, this.googlePlace, this.ontap);
  DetailsResult? detailsResult;
  List<Uint8List> images = [];
  // detailsResult.
  void getweatherdata() async {
    data = await NetworkHelper(
      "$kOwmUrl?lat=${detailsResult!.geometry!.location!.lat}&lon=${detailsResult!.geometry!.location!.lng}",
    ).getData();

    updateUI();
  }

  void updateUI() async {
    setState(() {
      if (data == null) {
        temp = 0;
        weatherIcon = "0";
        city = "";
        return;
      }
      print("DATA is $data");
      temp = (data["main"]["temp"] as double).floor();
      weatherIcon = model.getWeatherIcon(data["weather"][0]["id"]);
      humidity = (data["main"]["humidity"]as int).floor();
      wind = (data["wind"]["speed"] as double);
      city = data["name"];
    });
  }

  @override
  void initState() {
    getDetils(this.placeId);

    super.initState();
  }

  String? nameplace ;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // detailsResult != null && detailsResult!.types != null
    //     ?nameplace="City Details":
    nameplace = detailsResult?.addressComponents?.first.shortName.toString();
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: FloatingActionButton(
          foregroundColor: kPrimaryColor,
          backgroundColor: korangeColor,
          onPressed: this.ontap,
          child: Icon(
            Icons.add_circle_outlined
          ),
        ),
      ),
      appBar: PreferredSize(

        preferredSize: Size.fromHeight(size.height * 0.1),
        child: Container(
          decoration: BoxDecoration(
            // color: korangeColor,
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.chevron_left_outlined,
                  color: kPrimaryColor,
                  size: 35,
                ),
                onPressed: () {
                  print("Button pressed");
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text("$nameplace",style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 20
                ),),
              )
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.blueAccent,
      //   onPressed: () {
      //     getDetils(this.placeId);
      //   },
      //   child: Icon(Icons.refresh),
      // ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(right: 20, left: 20, top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 250,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.memory(
                            images[index],
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  height: size.height * 0.1,
                  child: Card(
                    elevation: 5,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListView(
                      children: <Widget>[
                        // Container(
                        //   padding: const EdgeInsets.symmetric(
                        //       horizontal: 2, vertical: 2),
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     borderRadius: BorderRadius.circular(29),
                        //   ),
                        //   child: Row(
                        //     children: [
                        //       SizedBox(width: 3.0),
                        //       Text(
                        //         weatherIcon,
                        //         style: TextStyle(
                        //           fontSize: 15.0,
                        //         ),
                        //       ),
                        //       SizedBox(width: 2.0),
                        //       Row(
                        //         children: [
                        //           Text(
                        //             temp.toString(),
                        //             style: TextStyle(
                        //               fontFamily: fontfamily,
                        //               fontWeight: FontWeight.w900,
                        //               color: kPrimaryColor,
                        //               fontSize: 20.0,
                        //             ),
                        //           ),
                        //           SizedBox(width: 1.0),
                        //           Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: [
                        //               Container(
                        //                 // decoration: kTempUnitBoxDecoration,
                        //                 child: Text(
                        //                   "O",
                        //                   style: TextStyle(
                        //                     fontFamily: fontfamily,
                        //                     fontWeight: FontWeight.w100,
                        //                     color: kPrimaryColor,
                        //                     fontSize: 10.0,
                        //                     height: 1.0,
                        //                   ),
                        //                 ),
                        //               ),
                        //               // Text(
                        //               //   city,
                        //               //   style: TextStyle(
                        //               //       fontFamily: fontfamily,
                        //               //       fontSize: 10.0,
                        //               //       color: kPrimaryColor),
                        //               // ),
                        //             ],
                        //           ),
                        //           SizedBox(width: 5.0),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.only(left: 15, top: 10),
                        //   child: Text(
                        //     "Details",
                        //     style: TextStyle(
                        //       fontSize: 20,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //   ),
                        // ),
                        // if(detailsResult==null)(
                        // const
                        // )
                        // detailsResult != null && detailsResult!.types != null
                        //     ? Container(
                        //         margin: EdgeInsets.only(left: 15, top: 10),
                        //         height: 50,
                        //         child: ListView.builder(
                        //           scrollDirection: Axis.horizontal,
                        //           itemCount: detailsResult!.types!.length,
                        //           itemBuilder: (context, index) {
                        //             return Container(
                        //               margin: EdgeInsets.only(right: 10),
                        //               child: Chip(
                        //                 label: Text(
                        //                   detailsResult!.types![index],
                        //                   style: TextStyle(
                        //                     color: Colors.white,
                        //                   ),
                        //                 ),
                        //                 backgroundColor: kPrimaryColor,
                        //               ),
                        //             );
                        //           },
                        //         ),
                        //       )
                        //     : Container(),
                        Column(

                          children: [
                            Text("Weather",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 20
                            ),),
                            Container(
                              width: size.width * 0.8,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 2),
                              decoration: BoxDecoration(
                                color: kgreycolor,
                                borderRadius: BorderRadius.circular(29),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(width: 3.0),
                                      Text(
                                        weatherIcon,
                                        style: TextStyle(
                                          fontSize: 25.0,
                                        ),
                                      ),
                                      SizedBox(width: 2.0),
                                      Text(
                                        temp.toString(),
                                        style: TextStyle(
                                          fontFamily: fontfamily,
                                          fontWeight: FontWeight.w900,
                                          color: kPrimaryColor,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      SizedBox(width: 1.0),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "O",
                                            style: TextStyle(
                                              fontFamily: fontfamily,
                                              fontWeight: FontWeight.w100,
                                              color: kPrimaryColor,
                                              fontSize: 10.0,
                                              height: 1.0,
                                            ),
                                          ),
                                          // Text(
                                          //   city,
                                          //   style: TextStyle(
                                          //       fontFamily: fontfamily,
                                          //       fontSize: 10.0,
                                          //       color: kPrimaryColor),
                                          // ),
                                        ],
                                      ),
                                      SizedBox(width: 5.0),
                                      Text("◎"),
                                      Icon(
                                        Icons.air
                                      ),
                                      Text("${wind.toString()}",
                                      style: TextStyle(
                                        fontFamily: fontfamily,
                                        fontWeight: FontWeight.w500,
                                        color: kPrimaryColor,
                                        fontSize: 20.0,

                                      ),),
                                      Text(" km/h"),
                                      SizedBox(width: 5.0),
                                      Text("◎"),
                                      Icon(
                                          Icons.opacity
                                      ),
                                      Text("${humidity.toString()}",
                                      style:TextStyle(
                                        fontFamily: fontfamily,
                                        fontWeight: FontWeight.w900,
                                        color: kPrimaryColor,
                                        fontSize: 20.0,
                                      )),
                                      Text(" %")
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Icon(Icons.location_on,color: kPrimaryColor,),
                              backgroundColor: korangeColor,
                            ),
                            title: Text(
                              detailsResult != null &&
                                  detailsResult!.formattedAddress != null
                                  ? 'Address: ${detailsResult!.formattedAddress}'
                                  : "Address: null",
                            ),
                          ),
                        ),
                        // Container(
                        //   margin: EdgeInsets.only(left: 15, top: 10),
                        //   child: ListTile(
                        //     leading: CircleAvatar(
                        //       child: Icon(Icons.location_searching),
                        //     ),
                        //     title: Text(
                        //       detailsResult != null &&
                        //               detailsResult!.geometry != null &&
                        //               detailsResult!.geometry!.location != null
                        //           ? 'Geometry: ${detailsResult!.geometry!.location!.lat.toString()},${detailsResult!.geometry!.location!.lng.toString()}'
                        //           : "Geometry: null",
                        //     ),
                        //   ),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.only(left: 15, top: 10),
                        //   child: ListTile(
                        //     leading: CircleAvatar(
                        //       child: Icon(Icons.timelapse),
                        //     ),
                        //     title: Text(
                        //       detailsResult != null &&
                        //               detailsResult!.utcOffset != null
                        //           ? 'UTC offset: ${detailsResult!.utcOffset.toString()} min'
                        //           : "UTC offset: null",
                        //     ),
                        //   ),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.only(left: 15, top: 10),
                        //   child: ListTile(
                        //     leading: CircleAvatar(
                        //       child: Icon(Icons.rate_review),
                        //     ),
                        //     title: Text(
                        //       detailsResult != null &&
                        //               detailsResult!.rating != null
                        //           ? 'Rating: ${detailsResult!.rating.toString()}'
                        //           : "Rating: null",
                        //     ),
                        //   ),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.only(left: 15, top: 10),
                        //   child: ListTile(
                        //     leading: CircleAvatar(
                        //       child: Icon(Icons.attach_money),
                        //     ),
                        //     title: Text(
                        //       detailsResult != null &&
                        //               detailsResult!.priceLevel != null
                        //           ? 'Price level: ${detailsResult!.priceLevel.toString()}'
                        //           : "Price level: null",
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              // Container(
              //   margin: EdgeInsets.only(top: 20, bottom: 10),
              //   child: Image.asset("assets/powered_by_google.png"),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void getDetils(String placeId) async {
    var result = await this.googlePlace.details.get(placeId);
    // locationis = result!.result!.geometry!.location;
    if (result != null && result.result != null && mounted) {
      setState(() {
        detailsResult = result.result!;
        images = [];
      });

      if (result.result!.photos != null) {
        for (var photo in result.result!.photos!) {
          print("Photo Address is ${photo.photoReference.toString()}");
          getPhoto(photo.photoReference.toString());
        }
      }
    }
    getweatherdata();
  }

  // Future<dynamic> getLocationData() async {
  //   WeatherModel model = WeatherModel();
  //   widget.locationWeather = await getLocationWeather();
  // }

  void getPhoto(String photoReference) async {
    var result = await this.googlePlace.photos.get(photoReference, 20, 400);
    if (result != null && mounted) {
      setState(() {
        images.add(result);
      });
    }
  }

}
