
import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:testing_app/constants.dart';
import 'detailpage_place_withweather.dart';
// import '../../constants.dart';
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await DotEnv().load('.env');
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HomePage(),
//     );
//   }
// }

class PlaceDetailsPage extends StatefulWidget {
  @override
  PlaceDetailsPageState createState() => PlaceDetailsPageState();
}

class PlaceDetailsPageState extends State<PlaceDetailsPage> {
  late GooglePlace googlePlace;

  List<AutocompletePrediction> predictions = [];

  @override
  void initState() {
    String apiKey = "AIzaSyD1OEikHgIeQaKYyV1Lo4hbTF9jCYVqvDg";
    googlePlace = GooglePlace(apiKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            // top: size.height * 0.05,
            // left: size.width * 0.05,
            padding: EdgeInsets.only(top: size.height * 0.05,
                left: size.width * 0.05),
            child: Row(
              children: <Widget>[
                Builder(builder: (context) {
                  return IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: kPrimaryColor,
                      size: 35,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                }),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text("Search",style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 20
                  ),),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 20, left: 20, top: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: "Search",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black54,
                        width: 2.0,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      autoCompleteSearch(value);
                    } else {
                      if (predictions.length > 0 && mounted) {
                        setState(() {
                          predictions = [];
                        });
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: predictions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          child: Icon(
                            Icons.pin_drop,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(predictions[index].description.toString()),
                        onTap: () {
                          debugPrint(predictions[index].placeId);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                placeId: predictions[index].placeId.toString(),
                                googlePlace: googlePlace,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.only(top: 10, bottom: 10),
                //   child: Image.asset("assets/powered_by_google.png"),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
      });
    }
  }
}

// class DetailsPage extends StatefulWidget {
//   // late final locationWeather;
//   final String placeId;
//   final GooglePlace googlePlace;
//
//
//   DetailsPage({Key? key, required this.placeId, required this.googlePlace}) : super(key: key);
//
//   @override
//   _DetailsPageState createState() =>
//       _DetailsPageState(this.placeId, this.googlePlace);
// }
//
// class _DetailsPageState extends State<DetailsPage> {
//   late dynamic data;
//   late final String placeId;
//   late final GooglePlace googlePlace;
//   var locationis ;
//
//   _DetailsPageState(this.placeId, this.googlePlace);
//
//   late DetailsResult detailsResult ;
//   // detailsResult = null;
//   List<Uint8List> images = [];
//
//   @override
//   void initState() {
//     // if(detailsResult==null){
//     //   CircularProgressIndicator();
//     // }
//     // else{
//     Center(child: CircularProgressIndicator());
//     Future.delayed(const Duration(milliseconds: 500) ,() {
//       getDetils(this.placeId);
//     });
//     // }
//
//     //getLocationData();
//     super.initState();
//     Future.delayed(const Duration(milliseconds: 500) ,() {
//       updateUI();
//     });
//     // updateUI();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Details"),
//         backgroundColor: Colors.blueAccent,
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.blueAccent,
//         onPressed: () {
//           getDetils(this.placeId);
//         },
//         child: Icon(Icons.refresh),
//       ),
//       body: SafeArea(
//         child: Container(
//           margin: EdgeInsets.only(right: 20, left: 20, top: 20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Container(
//                 height: 200,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: images.length,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       width: 250,
//                       child: Card(
//                         elevation: 4,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(10.0),
//                           child: Image.memory(
//                             images[index],
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Expanded(
//                 child: Card(
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   child: ListView(
//                     children: <Widget>[
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 2, vertical: 2),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(29),
//                         ),
//                         child: Row(
//                           children: [
//                             SizedBox(width: 3.0),
//                             Text(weatherIcon, style: TextStyle(
//                               fontSize: 15.0,
//                             ),),
//                             SizedBox(width: 2.0),
//                             Row(
//                               children: [
//                                 Text(temp.toString(), style: TextStyle(
//                                   fontFamily: fontfamily,
//                                   fontWeight: FontWeight.w900,
//                                   color: kPrimaryColor,
//                                   fontSize: 20.0,
//                                 ),
//                                 ),
//                                 SizedBox(width: 1.0),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       // decoration: kTempUnitBoxDecoration,
//                                       child: Text("O", style: TextStyle(
//                                         fontFamily: fontfamily,
//                                         fontWeight: FontWeight.w100,
//                                         color: kPrimaryColor,
//                                         fontSize: 10.0,
//                                         height: 1.0,
//                                       ),),
//                                     ),
//                                     Text(city, style: TextStyle(
//                                         fontFamily: fontfamily,
//                                         fontSize: 10.0,
//                                         color: kPrimaryColor
//                                     ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(width: 5.0),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(left: 15, top: 10),
//                         child: Text(
//                           "Details",
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       // if(detailsResult==null)(
//                       // const
//                       // )
//                       detailsResult != null && detailsResult.types != null
//                           ? Container(
//                         margin: EdgeInsets.only(left: 15, top: 10),
//                         height: 50,
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: detailsResult.types!.length,
//                           itemBuilder: (context, index) {
//                             return Container(
//                               margin: EdgeInsets.only(right: 10),
//                               child: Chip(
//                                 label: Text(
//                                   detailsResult.types![index],
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 backgroundColor: Colors.blueAccent,
//                               ),
//                             );
//                           },
//                         ),
//                       )
//                           : Container(),
//                       Container(
//                         margin: EdgeInsets.only(left: 15, top: 10),
//                         child: ListTile(
//                           leading: CircleAvatar(
//                             child: Icon(Icons.location_on),
//                           ),
//                           title: Text(
//                             detailsResult != null &&
//                                 detailsResult.formattedAddress != null
//                                 ? 'Address: ${detailsResult.formattedAddress}'
//                                 : "Address: null",
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(left: 15, top: 10),
//                         child: ListTile(
//                           leading: CircleAvatar(
//                             child: Icon(Icons.location_searching),
//                           ),
//                           title: Text(
//                             detailsResult != null &&
//                                 detailsResult.geometry != null &&
//                                 detailsResult.geometry!.location != null
//                                 ? 'Geometry: ${detailsResult.geometry!.location!.lat.toString()},${detailsResult.geometry!.location!.lng.toString()}'
//                                 : "Geometry: null",
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(left: 15, top: 10),
//                         child: ListTile(
//                           leading: CircleAvatar(
//                             child: Icon(Icons.timelapse),
//                           ),
//                           title: Text(
//                             detailsResult != null &&
//                                 detailsResult.utcOffset != null
//                                 ? 'UTC offset: ${detailsResult.utcOffset.toString()} min'
//                                 : "UTC offset: null",
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(left: 15, top: 10),
//                         child: ListTile(
//                           leading: CircleAvatar(
//                             child: Icon(Icons.rate_review),
//                           ),
//                           title: Text(
//                             detailsResult != null &&
//                                 detailsResult.rating != null
//                                 ? 'Rating: ${detailsResult.rating.toString()}'
//                                 : "Rating: null",
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(left: 15, top: 10),
//                         child: ListTile(
//                           leading: CircleAvatar(
//                             child: Icon(Icons.attach_money),
//                           ),
//                           title: Text(
//                             detailsResult != null &&
//                                 detailsResult.priceLevel != null
//                                 ? 'Price level: ${detailsResult.priceLevel.toString()}'
//                                 : "Price level: null",
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               // Container(
//               //   margin: EdgeInsets.only(top: 20, bottom: 10),
//               //   child: Image.asset("assets/powered_by_google.png"),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void getDetils(String placeId) async {
//     var result = await this.googlePlace.details.get(placeId);
//     locationis = result!.result!.geometry!.location;
//     if (result != null && result.result != null && mounted) {
//       setState(() {
//         detailsResult = result.result!;
//         images = [];
//       });
//
//       if (result.result!.photos != null) {
//         for (var photo in result.result!.photos!) {
//           getPhoto(photo.photoReference. toString());
//         }
//       }
//     }
//   }
//
//
//
//   // Future<dynamic> getLocationData() async {
//   //   WeatherModel model = WeatherModel();
//   //   widget.locationWeather = await getLocationWeather();
//   // }
//
//
//   Future<dynamic> getLocationWeather() async {
//     // var latitiueee = detailsResult.geometry!.location!.lat;
//     // print("Latitude $latitiueee");
//
//     return await NetworkHelper(
//       "$kOwmUrl?lat=${detailsResult.geometry!.location!.lat}&lon=${detailsResult.geometry!.location!.lng}",
//     ).getData();
//   }
//   WeatherModel model = WeatherModel();
//   late int temp=0;
//   late String city='', weatherIcon='0';
//
//   void updateUI() async{
//      data = await getLocationWeather();
//      var test= data["main"]["temp"];
//
//      print("data $test");
//     setState(() {
//       if (data == null) {
//         temp = 0;
//         weatherIcon = "0";
//         city = "";
//         return;
//       }
//
//
//       temp = (data["main"]["temp"] as double).floor();
//       weatherIcon = model.getWeatherIcon(data["weather"][0]["id"]);
//       city = data["name"];
//
//     });
//     //print("data $data");
//   }
//
//   void getPhoto(String photoReference) async {
//     var result = await this.googlePlace.photos.get(photoReference, 20, 400);
//     if (result != null && mounted) {
//       setState(() {
//         images.add(result);
//       });
//     }
//   }
// }
