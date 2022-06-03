import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'dart:math' as math;
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:intl/intl.dart';
import 'package:testing_app/Dashboard/DriverDashboard/components/itemsundersearchbar_items.dart';
import 'package:testing_app/Dashboard/TourCompany/makeaiternary/tripdata.dart';
import 'package:testing_app/ExpenseTrack/expensestracks.dart';
import 'package:testing_app/ExpenseTrack/transaction.dart';
import 'package:testing_app/ExpenseTrack/transactionsfortripdetails.dart';
import 'package:testing_app/Weather/screens/loading_screen.dart';
import 'package:testing_app/Weather/services/networking.dart';
import 'package:testing_app/Weather/services/weather.dart';
import 'package:testing_app/Weather/utilities/constants.dart';
import 'package:testing_app/constants.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:testing_app/Dashboard/TouristDashboard/searchplaceinaddatrip.dart';
// import '../user_search.dart';
import '../detailpage_place_withweather.dart';
import 'detailpagebottomsheetforviewplacedetail.dart';
import 'edittripdetails.dart';
import 'map_utils.dart';

class AddNewTrip extends StatelessWidget {
  String userid;
  String name;
  AddNewTrip({Key? key, required this.name, required this.userid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AddNewTripScreen(
        userid: this.userid,
        name: this.name,
      ),
    );
  }
}

class AddNewTripScreen extends StatefulWidget {
  String name;
  String userid;
  AddNewTripScreen({Key? key, required this.name, required this.userid}) : super(key: key);
  // BitmapDescriptor customIcon = BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(12, 12)),
  // 'assets/images/location_marker.png') as BitmapDescriptor;

  @override
  State createState() => AddNewTripScreenState();
}

class AddNewTripScreenState extends State<AddNewTripScreen> with TickerProviderStateMixin {
  late GooglePlace googlePlace;

  List<AutocompletePrediction> predictions = [];
  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  // TrackExpenses addexpense = TrackExpenses(userid: widget.userid,);
  // TrackExpensesState<addexpense> foraddingexpense = TrackExpensesState<addexpense>();
  late BitmapDescriptor myIcon;
  String? _darkMapStyle;
  // static const String kArtwork = "Left";
  // static const String kPastJobs = "Right";
  // final List<Tab> myTabs = <Tab>[
  //   const Tab(text: kArtwork),
  //   const Tab(text: kPastJobs)
  // ];
  // var color;
  Color selectedcolor = korangeColor;
  Color unSelectedcolor = kPrimaryColor;
  bool _isIncome = false;
  final _textcontrollerAMOUNT = TextEditingController();
  final _textcontrollerITEM = TextEditingController();
  bool selectedc = true;
  bool unselected = false;
  final _formKey = GlobalKey<FormState>();
  // Map<String, int> map1 = {'zero': 0, 'one': 1, 'two': 2};
  var PlacesObject = {};

  var NoteObject = {};
  Future _loadMapStyles() async {
    _darkMapStyle = await rootBundle.loadString('assets/maps/maps.json');
    // _lightMapStyle =
    // await rootBundle.loadString('assets/map_styles/light.json');
  }
  // Duplicate GlobalKey detected in widget tree
  // late TabController tabcontroller;

  // var countingcharsnote = "0";
  @override
  void initState() {
    super.initState();
    _loadMapStyles();
    getdata();
    String apiKey = "AIzaSyD1OEikHgIeQaKYyV1Lo4hbTF9jCYVqvDg";
    // tabcontroller = TabController(length: 2, vsync: this);
    googlePlace = GooglePlace(apiKey);

    // print("Dark mode is $_darkMapStyle");
    // final controller = _controller.future;
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(50, 60)), 'assets/images/location_marker_o.png').then((onValue) {
      myIcon = onValue;
    });
    // pageviewcontroller = PageController(initialPage: 0);
    _tabController = TabController(length: 3, vsync: this);
    // _tabController = TabController(vsync: this, length: myTabs.length);
  }

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(33.9070, 73.3943);
//  33.9070° N, 73.3943° E
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    // controller.animateCamera();
    // _darkMapStyle = await rootBundle.loadString('assets/maps/maps.json');
    controller.setMapStyle(_darkMapStyle);
    // _add();
  }

  List<Marker> markers = [];
  // Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  void _add() {
    // var markerIdVal = MyWayToGenerateId();
    final MarkerId markerId = MarkerId("Mure");
    final MarkerId markerId2 = MarkerId("Mure2");
    final MarkerId markerId3 = MarkerId("Mure3");
    final MarkerId markerId4 = MarkerId("dubai1");

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      // icon: BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(12, 12)),
      //     'assets/images/location_marker.bmp') as BitmapDescriptor ,
      icon: myIcon,
      position: LatLng(38.9100, 73.3950),
      infoWindow: InfoWindow(title: "Murree", snippet: '*'),
      onTap: () {
        // _onMarkerTapped(markerId);
      },
    );
    final Marker marker2 = Marker(
      markerId: MarkerId("Mure3"),
      // icon: BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(12, 12)),
      //     'assets/images/location_marker.bmp') as BitmapDescriptor ,
      icon: myIcon,
      position: LatLng(36.9200, 73.3743),
      infoWindow: InfoWindow(title: "Unknown Location 1", snippet: '*'),
      onTap: () {
        // _onMarkerTapped(markerId);
      },
    );
    final Marker marker3 = Marker(
      markerId: markerId3,
      // icon: BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(12, 12)),
      //     'assets/images/location_marker.bmp') as BitmapDescriptor ,
      icon: myIcon,
      position: LatLng(34.9070, 73.3943),
      infoWindow: InfoWindow(title: "Testing third marker", snippet: '*'),
      onTap: () {
        // _onMarkerTapped(markerId);
      },
    );
    final Marker marker4 = Marker(
      markerId: markerId,
      // icon: BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(12, 12)),
      //     'assets/images/location_marker.bmp') as BitmapDescriptor ,
      icon: myIcon,
      position: LatLng(25.2048, 55.2708),
      infoWindow: InfoWindow(title: "Dubai", snippet: '*'),
      onTap: () {
        // _onMarkerTapped(markerId);
      },
    );
    // markers.addAll(other);
    //  markers.update(markerId, (value) => marker);
    // markers.update(markerId2, (value) => marker2);
    // markers.update(markerId3, (value) => marker3);
    setState(() {
      // adding a new marker to map
      // markers[markerId] = marker;
      // markers[markerId2] = marker2;
      markers.add(
          Marker(
            markerId: MarkerId("Mure3"),
            // icon: BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(12, 12)),
            //     'assets/images/location_marker.bmp') as BitmapDescriptor ,
            icon: myIcon,
            position: LatLng(36.9200, 73.3743),
            infoWindow: InfoWindow(title: "Unknown Location 1", snippet: '*'),
            onTap: () {
              // _onMarkerTapped(markerId);
            },
          )
      );
      markers.add(marker2);
      markers.add(marker3);
      markers.add(marker4);

      // Future.delayed(Duration(milliseconds: 10)).then((value) {
      //   GeoBox target = GeoBox.containingGeoCoordinates(markers);
      //   mapController.camera
      //       .lookAtAreaWithOrientation(target, MapCameraOrientationUpdate(20, 0));
      // });
      Future.delayed(Duration(milliseconds: 200), () {
        mapController.animateCamera(
          CameraUpdate.newLatLngBounds(MapUtils.boundsFromLatLngList(markers.map((loc) => loc.position).toList()), 20),
        );
        // animateCamera(CameraUpdate.zoomOut());
      });
      // Future.delayed(
      //   Duration(milliseconds: 200),
      //     //   () => mapController.animateCamera(
      //     // CameraUpdate.newLatLngBounds(MapUtils.boundsFromLatLngList(markers.map((loc) => loc.position).toList()), 1),
      //     () => mapController.animateCamera(CameraUpdate.zoomOut(),
      //   ),
      // );
      mapController.animateCamera(CameraUpdate.zoomOut());
      // markers[markerId2] = marker2;
      // markers[markerId3] = marker3;
      // markers.update(markerId, (value) => marker);
      // markers.update(markerId2, (value) => marker2);
      // markers.update(markerId3, (value) => marker3);

      // markers.addAll({markerId:marker,markerId2:marker2,markerId3:marker3});
    });
  }

  late TabController _tabController;
  //= TabController(length: 3, vsync:this);
  List<Tab> myTabs = [
    Tab(text: 'LEFT'),
    Tab(text: 'RIGHT'),
  ];

  List<Widget> tabslist = [
  ];
  List<String> namesday = [];
  var number = 0;
  List<Widget> tabsScreenlist = [ ];
  PageController pageviewcontroller = PageController();
  // = PageController(initialPage: 0);
  var currentPageValue = 0.0;
  Widget daywidget = Text("There is no days");

  // MarkerId? selectedMarker;
  // LatLng? markerPosition;
  // void _onMarkerTapped(MarkerId markerId) {
  //   final Marker? tappedMarker = markers[markerId];
  //   if (tappedMarker != null) {
  //     setState(() {
  //       final MarkerId? previousMarkerId = selectedMarker;
  //       if (previousMarkerId != null && markers.containsKey(previousMarkerId)) {
  //         final Marker resetOld = markers[previousMarkerId]!
  //             .copyWith(iconParam: BitmapDescriptor.defaultMarker);
  //         markers[previousMarkerId] = resetOld;
  //       }
  //       selectedMarker = markerId;
  //       final Marker newMarker = tappedMarker.copyWith(
  //         iconParam: BitmapDescriptor.defaultMarkerWithHue(
  //           BitmapDescriptor.hueGreen,
  //         ),
  //       );
  //       markers[markerId] = newMarker;
  //
  //       markerPosition = null;
  //     });
  //   }
  // }
  // List<Widget>

  DateTime? selectedDate = null;

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? picked =
  //       await showDatePicker(context: context, initialDate: selectedDate, firstDate: DateTime(2015, 8), lastDate: DateTime(2101));
  //   if (picked != null && picked != selectedDate) {
  //     setState(() {
  //       selectedDate = picked;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: CupertinoColors.white,
        shadowColor: Colors.transparent,
        title: Text(
          "",
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
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return EditTripDetailsScreen(
                        name: widget.name, data:TripData(),
                      );
                    }),
                  );
                },
                child: Icon(
                  Icons.edit_outlined,
                  size: 26.0,
                  color: kPrimaryColor,
                ),
              )),
          // Padding(
          //     padding: EdgeInsets.only(right: 20.0),
          //     child: GestureDetector(
          //       onTap: () {},
          //       child: Icon(
          //           Icons.more_vert
          //       ),
          //     )
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //   Positioned(
            //     top: 0,
            //     child: Container(
            //     width: size.width,
            //     height: size.height * 0.3,
            //     decoration: BoxDecoration(
            //       // color: CupertinoColors.black,
            //       image: DecorationImage(
            //         image: AssetImage("assets/images/inplaceofmaps.png"),
            //         fit: BoxFit.cover
            //       ),
            //       borderRadius: BorderRadius.only(
            //           bottomLeft: Radius.circular(20),
            //           bottomRight: Radius.circular(20)),
            //     ),
            // ),
            //   ),
            Container(
              width: size.width,
              height: size.height * 0.26,
              decoration: BoxDecoration(
                // color: CupertinoColors.black,
                // image: DecorationImage(
                //     image: AssetImage("assets/images/inplaceofmaps.png"),
                //     fit: BoxFit.cover
                // ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: GoogleMap(
                tiltGesturesEnabled: false,
                mapToolbarEnabled: false,
                rotateGesturesEnabled: false,
                scrollGesturesEnabled: false,
                zoomControlsEnabled: false,
                zoomGesturesEnabled: false,
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
                // myLocationEnabled: true,
                markers: Set<Marker>.of(markers),
              ),
            ),
            // Spacer(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: size.width,
                height: size.height * 0.08,
                // color: korangeColor,
                decoration: BoxDecoration(
                    // color: kgreycolor,
                    // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                    ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          (widget.name.length > 12) ? widget.name.substring(0, 12) + "..." : widget.name,
                          style: TextStyle(
                            fontSize: size.width * 0.1,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Container(
                        //   width: 30,
                        //   height: 30,
                        //   decoration: BoxDecoration(color: korangeColor, borderRadius: BorderRadius.circular(50)),
                        //   child: Icon(
                        //     Icons.edit,
                        //     color: CupertinoColors.white,
                        //     size: 20,
                        //   ),
                        // ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        // "∘"
                        " 0 items",
                        style: TextStyle(fontSize: 12, color: korangeColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10),
                  child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Container(
                      width: size.width * 0.5,
                      // height: size.height * 0.1,
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(right: size.width * 0.45),
                      decoration: BoxDecoration(
                          // color: CupertinoColors.black,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1.8, color: korangeColor)),
                      child: InkWell(
                        highlightColor: kgreycolor,
                        onTap: () {
                          showModalBottomSheet<void>(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 180,
                                decoration: BoxDecoration(
                                  color: CupertinoColors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          width: size.width * 0.2,
                                          height: 5,
                                          decoration: BoxDecoration(color: korangeColor, borderRadius: BorderRadius.circular(50))),
                                    ),
                                    const Text(
                                      'Traveling Dates',
                                      style: TextStyle(color: kPrimaryColor, fontSize: 18, fontWeight: FontWeight.w500),
                                    ),
                                    Divider(
                                      color: Colors.transparent,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                          showModalBottomSheet(
                                              backgroundColor: Colors.transparent,
                                              context: context,
                                              builder: (BuildContext context) {
                                                return BottomSheet(
                                                  onClosing: () {},
                                                  builder: (BuildContext context) {
                                                    number = 0;
                                                    return StatefulBuilder(
                                                      builder: (BuildContext context, setState) => Container(
                                                        height: 180,
                                                        decoration: BoxDecoration(
                                                          color: CupertinoColors.white,
                                                          borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(20),
                                                            topRight: Radius.circular(20),
                                                          ),
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Container(
                                                                  width: size.width * 0.2,
                                                                  height: 5,
                                                                  decoration:
                                                                      BoxDecoration(color: korangeColor, borderRadius: BorderRadius.circular(50))),
                                                            ),
                                                            Text(
                                                              'Days',
                                                              style: TextStyle(color: kPrimaryColor, fontSize: 18, fontWeight: FontWeight.w500),
                                                            ),
                                                            Divider(
                                                              color: Colors.transparent,
                                                            ),
                                                            Container(
                                                              height: size.height * 0.07,
                                                              // color: CupertinoColors.black,
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  SizedBox(
                                                                    width: size.width * 0.5,
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.only(left: 18.0),
                                                                      child: Text(
                                                                        "Number of Days",
                                                                        style: TextStyle(
                                                                          color: kPrimaryColor,
                                                                          fontSize: 15,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: size.width * 0.5,
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.only(right: 18.0),
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                                        children: [
                                                                          GestureDetector(
                                                                            onTap: () {
                                                                              setState(() {
                                                                                if (number != 0) {
                                                                                  number--;
                                                                                }
                                                                              });
                                                                            },
                                                                            child: Container(
                                                                                decoration: BoxDecoration(
                                                                                    color: kPrimaryColor, borderRadius: BorderRadius.circular(10)),
                                                                                child: const Icon(
                                                                                  Icons.remove_outlined,
                                                                                  color: korangeColor,
                                                                                )),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                                                            child: Text(
                                                                              number.toString(),
                                                                              style: const TextStyle(
                                                                                color: kPrimaryColor,
                                                                                fontSize: 18,
                                                                                // decoration: TextDecoration.underline
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          GestureDetector(
                                                                            onTap: () {
                                                                              setState(() {
                                                                                number++;
                                                                              });
                                                                            },
                                                                            child: Container(
                                                                                decoration: BoxDecoration(
                                                                                    color: kPrimaryColor, borderRadius: BorderRadius.circular(10)),
                                                                                child: const Icon(
                                                                                  Icons.add,
                                                                                  color: korangeColor,
                                                                                )),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              height: size.height * 0.07,
                                                              // color: CupertinoColors.black,
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.only(left: 18.0),
                                                                    child: InkWell(
                                                                      onTap: () {
                                                                        setState(() {
                                                                          number = 0;
                                                                        });
                                                                      },
                                                                      child: Text(
                                                                        "Zero",
                                                                        style: TextStyle(
                                                                            color: kPrimaryColor, fontSize: 15, decoration: TextDecoration.underline),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(right: 18.0),
                                                                    child: Container(
                                                                      width: size.width * 0.18,
                                                                      height: size.height * 0.04,
                                                                      decoration: BoxDecoration(
                                                                          color: kPrimaryColor, borderRadius: BorderRadius.circular(10)),
                                                                      child: TextButton(
                                                                        onPressed: () {
                                                                          if (tabsScreenlist.isNotEmpty) {
                                                                            tabsScreenlist = [];
                                                                            tabslist = [];
                                                                          }
                                                                          print("I am being presseed");
                                                                          Navigator.pop(context);
                                                                          this.setState(() {
                                                                            namesday = [];
                                                                            tabslist = [];
                                                                            for (int i = 1; i <= number; i++) {
                                                                              namesday.add("Day $i");
                                                                              tabslist.add(GestureDetector(
                                                                                onTap: () {
                                                                                  dispose();
                                                                                  print("I am pressed and i am in mounted");
                                                                                  setState(() {
                                                                                    selectedc = false;
                                                                                  });

                                                                                  print("I am pressed and i am outside mounted");
                                                                                },
                                                                                child: Container(
                                                                                  height: size.height * 0.05,
                                                                                  decoration: BoxDecoration(
                                                                                    color: selectedc == false ? kPrimaryColor : korangeColor,
                                                                                    borderRadius: BorderRadius.circular(20),
                                                                                  ),
                                                                                  child: Center(
                                                                                    child: Row(
                                                                                      children: <Widget>[
                                                                                        Padding(
                                                                                          padding: EdgeInsets.only(
                                                                                            right: size.width * 0.025,
                                                                                          ),
                                                                                          child: Text(
                                                                                            "Day $i",
                                                                                            style: TextStyle(color: Colors.white),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ));
                                                                              tabsScreenlist.add(
                                                                                Column(
                                                                                  children: [
                                                                                    Container(
                                                                                      width: 30,
                                                                                      height: 30,
                                                                                      decoration: BoxDecoration(
                                                                                          color: korangeColor,
                                                                                          borderRadius: BorderRadius.circular(50)),
                                                                                      child: Icon(
                                                                                        Icons.add,
                                                                                        color: CupertinoColors.white,
                                                                                        size: 20,
                                                                                      ),
                                                                                    ),
                                                                                    Center(
                                                                                      child: Text('Day $i',
                                                                                          style:
                                                                                              TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              );
                                                                            }
                                                                            print("List is $tabslist");

                                                                            // tabslist = tabs;
                                                                            // namesday = days;
                                                                          });
                                                                          // pageviewcontroller.
                                                                        },
                                                                        child: Text(
                                                                          "Apply",
                                                                          style: TextStyle(color: korangeColor),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              });
                                        },
                                        child: Center(
                                          child: const Text(
                                            'Days(Day 1)',
                                            style: TextStyle(color: korangeColor, fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () async {
                                          // final DateTime? picked = null;
                                          Navigator.pop(context);
                                          final DateTime? picked = await showDatePicker(
                                              initialEntryMode: DatePickerEntryMode.calendarOnly,
                                              helpText: "Select Departure Date",
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2015, 8),
                                              lastDate: DateTime(2101),
                                              builder: (context, child) {
                                                return Theme(
                                                    data: ThemeData.dark().copyWith(
                                                        colorScheme: ColorScheme.dark(
                                                            primary: korangeColor,
                                                            onPrimary: CupertinoColors.white,
                                                            surface: CupertinoColors.white,
                                                            onSurface: kPrimaryColor,
                                                            background: CupertinoColors.white),
                                                        dialogBackgroundColor: CupertinoColors.white,
                                                        dialogTheme: DialogTheme(
                                                          elevation: 0.0,
                                                          // backgroundColor: korangeColor
                                                        )),
                                                    child: child!);
                                              });

                                          if (picked != null && picked != selectedDate) {
                                            setState(() {
                                              selectedDate = picked;
                                            });
                                          }
                                        },
                                        child: Center(
                                          child: const Text(
                                            'Dates(DD/MM)',
                                            style: TextStyle(color: korangeColor, fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                    // const Text('Dates(DD/MM)'),
                                    Divider(),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.today_outlined,
                                color: kPrimaryColor,
                                size: size.width * 0.05,
                              ),
                              Text(
                                selectedDate == null ? "Add your travel Dates" : " ${DateFormat('EEE, MMM d').format(selectedDate!)}",
                                style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w500, fontSize: size.width * 0.035),
                              ),
                              selectedDate != null
                                  ? InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedDate = null;
                                        });
                                      },
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(color: korangeColor, borderRadius: BorderRadius.circular(100)),
                                        child: Icon(
                                          Icons.clear,
                                          size: 15,
                                        ),
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Row(
                    //   children: tabslist,
                    // )
                    tabslist.isNotEmpty
                        ? Container(
                            // margin: EdgeInsets.all(10),
                            height: size.height * 0.06,
                            child: ListView.builder(
                              // key: Key(getRandomString(10)),
                              itemCount: tabslist.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                var numofday = index + 1;
                                return GestureDetector(
                                  onTap: () {
                                    print("I am pressed and i am in mounted");
                                    setState(() {
                                      print("INdex is $index");
                                      pageviewcontroller.jumpToPage(index);
                                      // pageviewcontroller.initialPage;

                                      if (selectedc == true) {
                                        selectedc = false;
                                        selectedcolor = kPrimaryColor;
                                        unSelectedcolor = korangeColor;
                                      } else {
                                        selectedc = true;
                                        selectedcolor = korangeColor;
                                        unSelectedcolor = kPrimaryColor;
                                      }
                                      // selectedc = false;
                                    });

                                    print("I am pressed and i am outside mounted");
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      left: 10,
                                      bottom: 10,
                                      top: 10,
                                    ),
                                    // height: size.height * 0.1,
                                    decoration: BoxDecoration(
                                      color: selectedc == false ? selectedcolor : unSelectedcolor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                        child: Text(
                                          "Day $numofday",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                                // tabslist[index];
                              },
                            ),
                          )
                        : Text(""),
                    const Divider(),
                    tabsScreenlist.isNotEmpty
                        ? SizedBox(
                            height: size.height * 0.66,
                            child: PageView.builder(
                              // shrinkWrap: true,
                              // key: Key(getRandomString(10)),
                              controller: pageviewcontroller,
                              // children: tabsScreenlist,
                              itemCount: tabsScreenlist.length,
                              itemBuilder: (context, index) {
                                String numofpages = getRandomString(5);
                                var day = index + 1;
                                return Container(
                                  height: size.height * 0.66,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Column(
                                      children: [
                                        // give the tab bar a height [can change hheight to preferred height]
                                        Container(
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: kgreycolor,
                                            borderRadius: BorderRadius.circular(
                                              10.0,
                                            ),
                                          ),
                                          child: TabBar(
                                            controller: _tabController,
                                            // give the indicator a decoration (color and border radius)
                                            indicator: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                10.0,
                                              ),
                                              color: korangeColor,
                                            ),
                                            labelColor: kPrimaryColor,
                                            unselectedLabelColor: korangeColor,
                                            tabs: [
                                              // first tab [you can add an icon using the icon property]
                                              Tab(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [Text("Places "), Icon(Icons.place_outlined)],
                                                ),
                                              ),

                                              // second tab [you can add an icon using the icon property]
                                              Tab(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [Text("Activites "), Icon(Icons.summarize)],
                                                ),
                                              ),
                                              Tab(icon: Container(child: Icon(Icons.paid))
                                                // child: Row(
                                                //   mainAxisAlignment: MainAxisAlignment.center,
                                                //   children: [ Icon(Icons.paid)],
                                                // ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // tab bar view here
                                        Expanded(
                                          child: TabBarView(
                                            controller: _tabController,
                                            children: [
                                              Column(
                                                children: [
                                                  Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(top: 8.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Places on Day ${index + 1}",
                                                            style: TextStyle(
                                                                fontSize: 25, fontWeight: FontWeight.w600, color: kPrimaryColor),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              var placeslistofdays=[];
                                                              print("Day number is ${index}");
                                                              print("List is before $placeslistofdays");
                                                              if(PlacesObject.isNotEmpty) {

                                                                if(PlacesObject.containsKey('day${index+1}')) {
                                                                  print("Object list of place is ${PlacesObject['day${index+1}']['places']}");
                                                                  placeslistofdays = PlacesObject['day${index+1}']['places'];
                                                                }
                                                              }
                                                              print("List is after $placeslistofdays");
                                                              print("I am pressedddd");
                                                              showModalBottomSheet(
                                                                // shape: RoundedRectangleBorder(
                                                                //     borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
                                                                  backgroundColor: Colors.transparent,
                                                                  context: context,
                                                                  // isScrollControlled: true,
                                                                  builder: (BuildContext context) {
                                                                    return BottomSheet(
                                                                      // isScrollControlled: true,
                                                                      onClosing: () {},
                                                                      builder: (BuildContext context) {
                                                                        number = 0;
                                                                        return StatefulBuilder(
                                                                          builder: (BuildContext context, setState) {
                                                                            return Container(
                                                                              decoration: BoxDecoration(
                                                                                color: CupertinoColors.white,
                                                                                borderRadius: BorderRadius.only(
                                                                                  topLeft: Radius.circular(20),
                                                                                  topRight: Radius.circular(20),
                                                                                ),
                                                                              ),
                                                                              child: Column(
                                                                                // mainAxisSize: MainAxisSize.min,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: Container(
                                                                                        width: size.width * 0.2,
                                                                                        height: 5,
                                                                                        decoration: BoxDecoration(
                                                                                            color: korangeColor,
                                                                                            borderRadius: BorderRadius.circular(50))),
                                                                                  ),
                                                                                  Text(
                                                                                    'Places',
                                                                                    style: TextStyle(
                                                                                        color: kPrimaryColor,
                                                                                        fontSize: 18,
                                                                                        fontWeight: FontWeight.w500),
                                                                                  ),
                                                                                  Divider(
                                                                                    color: Colors.transparent,
                                                                                  ),
                                                                                  Container(
                                                                                    width: size.width * 0.8,
                                                                                    child: TextField(
                                                                                      cursorColor: kPrimaryColor,
                                                                                      cursorHeight: 25,
                                                                                      decoration: InputDecoration(
                                                                                        focusedBorder: OutlineInputBorder(
                                                                                          borderSide: BorderSide(
                                                                                            color: korangeColor,
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
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.all(10.0),
                                                                                      child: ListView.builder(
                                                                                        itemCount: predictions.length > 3
                                                                                            ? 3
                                                                                            : predictions.length,
                                                                                        itemBuilder: (context, indexitembuilder) {
                                                                                          return ListTile(
                                                                                            leading: CircleAvatar(
                                                                                              backgroundColor: kPrimaryColor,
                                                                                              child: Icon(
                                                                                                Icons.attractions,
                                                                                                color: korangeColor,
                                                                                              ),
                                                                                            ),
                                                                                            title: Text(predictions[indexitembuilder]
                                                                                                .description
                                                                                                .toString()),
                                                                                            onTap: () async {
                                                                                              await getDetils(
                                                                                                  predictions[indexitembuilder].placeId.toString(),
                                                                                                  setState,
                                                                                                  context);
                                                                                              nameplace = detailsResult
                                                                                                  ?.addressComponents?.first.shortName
                                                                                                  .toString();
                                                                                              Navigator.pop(context);

                                                                                              showModalBottomSheet<void>(
                                                                                                context: context,
                                                                                                builder: (BuildContext context) {
                                                                                                  return Container(
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: CupertinoColors.white,
                                                                                                        borderRadius: BorderRadius.only(
                                                                                                          topLeft: Radius.circular(20),
                                                                                                          topRight: Radius.circular(20),
                                                                                                        ),
                                                                                                      ),
                                                                                                      child: Scaffold(
                                                                                                        floatingActionButton: Padding(
                                                                                                          padding: const EdgeInsets.only(
                                                                                                              right: 20.0),
                                                                                                          child: FloatingActionButton(
                                                                                                            foregroundColor:
                                                                                                            kPrimaryColor,
                                                                                                            backgroundColor: korangeColor,
                                                                                                            onPressed: () async{
                                                                                                              Navigator.pop(context);
                                                                                                              Navigator.pop(context);
                                                                                                              //TODO : here adding place
                                                                                                              print("I am pressed");
                                                                                                              placeslistofdays.add(
                                                                                                                  {
                                                                                                                    "placeid":
                                                                                                                    detailsResult!.placeId,
                                                                                                                    "Name": detailsResult!.name,
                                                                                                                  });
                                                                                                              print("I am pressed x2");
                                                                                                              this.setState(() {
                                                                                                                PlacesObject["day${index+1}"] = {
                                                                                                                  "notes":{},
                                                                                                                  "places":placeslistofdays

                                                                                                                };
                                                                                                              });
                                                                                                              //TODO : Adding on maps here
                                                                                                              this.setState(() {
                                                                                                                markers.add(
                                                                                                                    Marker(
                                                                                                                      markerId: MarkerId(detailsResult!.placeId.toString()),
                                                                                                                      // icon: BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(12, 12)),
                                                                                                                      //     'assets/images/location_marker.bmp') as BitmapDescriptor ,
                                                                                                                      icon: myIcon,
                                                                                                                      position: LatLng(detailsResult!.geometry!.location!.lat!, detailsResult!.geometry!.location!.lng!),
                                                                                                                      infoWindow: InfoWindow(title: "${detailsResult!.name}", snippet: '${detailsResult!.formattedAddress}'),
                                                                                                                      onTap: () {
                                                                                                                        // _onMarkerTapped(markerId);
                                                                                                                      },
                                                                                                                    )
                                                                                                                );
                                                                                                                print("Markers is ${markers}");
                                                                                                                Future.delayed(Duration(milliseconds: 200), () {
                                                                                                                  mapController.animateCamera(
                                                                                                                    CameraUpdate.newLatLngBounds(MapUtils.boundsFromLatLngList(markers.map((loc) => loc.position).toList()), 20),
                                                                                                                  );
                                                                                                                  // animateCamera(CameraUpdate.zoomOut());
                                                                                                                });
                                                                                                                mapController.animateCamera(CameraUpdate.zoomOut());
                                                                                                              });



                                                                                                              print("Days Places List is ${PlacesObject}");
                                                                                                              // await getDetils(
                                                                                                              //     detailsResult!.placeId.toString(),
                                                                                                              //     setState,
                                                                                                              //     context);
                                                                                                              // print("Days Places List is ${PlacesObject}");
                                                                                                            },
                                                                                                            child: Icon(Icons
                                                                                                                .add_circle_outlined),
                                                                                                          ),
                                                                                                        ),
                                                                                                        appBar: PreferredSize(
                                                                                                          preferredSize: Size.fromHeight(
                                                                                                              size.height * 0.1),
                                                                                                          child: Container(
                                                                                                            decoration: BoxDecoration(
                                                                                                              // color: korangeColor,
                                                                                                            ),
                                                                                                            child: Row(
                                                                                                              children: [
                                                                                                                IconButton(
                                                                                                                  icon: const Icon(
                                                                                                                    Icons
                                                                                                                        .chevron_left_outlined,
                                                                                                                    color: kPrimaryColor,
                                                                                                                    size: 35,
                                                                                                                  ),
                                                                                                                  onPressed: () {
                                                                                                                    print(
                                                                                                                        "Button pressed");
                                                                                                                    Navigator.pop(
                                                                                                                        context);
                                                                                                                  },
                                                                                                                ),
                                                                                                                Padding(
                                                                                                                  padding:
                                                                                                                  const EdgeInsets
                                                                                                                      .only(left: 10),
                                                                                                                  child: Text(
                                                                                                                    "$nameplace",
                                                                                                                    style: TextStyle(
                                                                                                                        color:
                                                                                                                        kPrimaryColor,
                                                                                                                        fontSize: 20),
                                                                                                                  ),
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
                                                                                                            margin: EdgeInsets.only(
                                                                                                                right: 20,
                                                                                                                left: 20,
                                                                                                                top: 20),
                                                                                                            child: Column(
                                                                                                              mainAxisSize:
                                                                                                              MainAxisSize.min,
                                                                                                              children: <Widget>[
                                                                                                                Container(
                                                                                                                  height: 200,
                                                                                                                  child: ListView.builder(
                                                                                                                    scrollDirection:
                                                                                                                    Axis.horizontal,
                                                                                                                    itemCount:
                                                                                                                    images.length,
                                                                                                                    itemBuilder:
                                                                                                                        (context, index) {
                                                                                                                      return Container(
                                                                                                                        width: 250,
                                                                                                                        child: Card(
                                                                                                                          elevation: 4,
                                                                                                                          shape:
                                                                                                                          RoundedRectangleBorder(
                                                                                                                            borderRadius:
                                                                                                                            BorderRadius
                                                                                                                                .circular(
                                                                                                                                10.0),
                                                                                                                          ),
                                                                                                                          child:
                                                                                                                          ClipRRect(
                                                                                                                            borderRadius:
                                                                                                                            BorderRadius
                                                                                                                                .circular(
                                                                                                                                10.0),
                                                                                                                            child: Image
                                                                                                                                .memory(
                                                                                                                              images[
                                                                                                                              index],
                                                                                                                              fit: BoxFit
                                                                                                                                  .fitHeight,
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
                                                                                                                    height:
                                                                                                                    size.height * 0.1,
                                                                                                                    child: Card(
                                                                                                                      elevation: 5,
                                                                                                                      shape:
                                                                                                                      RoundedRectangleBorder(
                                                                                                                        borderRadius:
                                                                                                                        BorderRadius
                                                                                                                            .circular(
                                                                                                                            10.0),
                                                                                                                      ),
                                                                                                                      child: ListView(
                                                                                                                        children: <
                                                                                                                            Widget>[
                                                                                                                          Column(
                                                                                                                            children: [
                                                                                                                              Text(
                                                                                                                                "Weather",
                                                                                                                                style: TextStyle(
                                                                                                                                    color:
                                                                                                                                    kPrimaryColor,
                                                                                                                                    fontSize:
                                                                                                                                    20),
                                                                                                                              ),
                                                                                                                              Container(
                                                                                                                                width: size
                                                                                                                                    .width *
                                                                                                                                    0.8,
                                                                                                                                padding: const EdgeInsets
                                                                                                                                    .symmetric(
                                                                                                                                    horizontal:
                                                                                                                                    2,
                                                                                                                                    vertical:
                                                                                                                                    2),
                                                                                                                                decoration:
                                                                                                                                BoxDecoration(
                                                                                                                                  color:
                                                                                                                                  kgreycolor,
                                                                                                                                  borderRadius:
                                                                                                                                  BorderRadius.circular(29),
                                                                                                                                ),
                                                                                                                                child:
                                                                                                                                Center(
                                                                                                                                  child:
                                                                                                                                  Padding(
                                                                                                                                    padding:
                                                                                                                                    const EdgeInsets.all(8.0),
                                                                                                                                    child:
                                                                                                                                    Row(
                                                                                                                                      mainAxisAlignment:
                                                                                                                                      MainAxisAlignment.spaceBetween,
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
                                                                                                                                        Icon(Icons.air),
                                                                                                                                        Text(
                                                                                                                                          "${wind.toString()}",
                                                                                                                                          style: TextStyle(
                                                                                                                                            fontFamily: fontfamily,
                                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                                            color: kPrimaryColor,
                                                                                                                                            fontSize: 20.0,
                                                                                                                                          ),
                                                                                                                                        ),
                                                                                                                                        Text(" km/h"),
                                                                                                                                        SizedBox(width: 5.0),
                                                                                                                                        Text("◎"),
                                                                                                                                        Icon(Icons.opacity),
                                                                                                                                        Text("${humidity.toString()}",
                                                                                                                                            style: TextStyle(
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
                                                                                                                            padding: const EdgeInsets
                                                                                                                                .only(
                                                                                                                                left:
                                                                                                                                30.0),
                                                                                                                            child:
                                                                                                                            ListTile(
                                                                                                                              leading:
                                                                                                                              CircleAvatar(
                                                                                                                                child:
                                                                                                                                Icon(
                                                                                                                                  Icons
                                                                                                                                      .location_on,
                                                                                                                                  color:
                                                                                                                                  kPrimaryColor,
                                                                                                                                ),
                                                                                                                                backgroundColor:
                                                                                                                                korangeColor,
                                                                                                                              ),
                                                                                                                              title: Text(
                                                                                                                                detailsResult != null &&
                                                                                                                                    detailsResult!.formattedAddress != null
                                                                                                                                    ? 'Address: ${detailsResult!.formattedAddress}'
                                                                                                                                    : "Address: null",
                                                                                                                              ),
                                                                                                                            ),
                                                                                                                          ),
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
                                                                                                      )
                                                                                                    // DetailsPageBottomSheet(
                                                                                                    //   placeId:
                                                                                                    //       predictions[index].placeId.toString(),
                                                                                                    //   googlePlace: googlePlace,
                                                                                                    // ),
                                                                                                  );
                                                                                                },
                                                                                              );
                                                                                            },
                                                                                          );
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            );
                                                                          },
                                                                        );
                                                                      },
                                                                    );
                                                                  });
                                                            },
                                                            child: Icon(
                                                              Icons.add_circle,
                                                              size: size.width * 0.08,
                                                              color: kPrimaryColor,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SingleChildScrollView(
                                                    child: Container(
                                                      height: size.height * 0.564,
                                                      child: ListView.builder(
                                                          itemCount: PlacesObject.isNotEmpty?PlacesObject.containsKey('day${index+1}')?PlacesObject['day${index+1}']['places'].length:0:0,
                                                          itemBuilder: (BuildContext context, int indexlistview) {
                                                            return Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  InkWell(
                                                                    onTap:() async{
                                                                      await getDetils(
                                                                          PlacesObject['day${index+1}']['places'][indexlistview]['placeid'].toString(),
                                                                          setState,
                                                                          context);
                                                                      nameplace = detailsResult
                                                                          ?.addressComponents?.first.shortName
                                                                          .toString();
                                                                      Navigator.pop(context);


                                                                      showModalBottomSheet<void>(
                                                                        context: context,
                                                                        builder: (BuildContext context) {
                                                                          return Container(
                                                                              decoration: BoxDecoration(
                                                                                color: CupertinoColors.white,
                                                                                borderRadius: BorderRadius.only(
                                                                                  topLeft: Radius.circular(20),
                                                                                  topRight: Radius.circular(20),
                                                                                ),
                                                                              ),
                                                                              child: Scaffold(
                                                                                appBar: PreferredSize(
                                                                                  preferredSize: Size.fromHeight(
                                                                                      size.height * 0.1),
                                                                                  child: Container(
                                                                                    decoration: BoxDecoration(
                                                                                      // color: korangeColor,
                                                                                    ),
                                                                                    child: Row(
                                                                                      children: [
                                                                                        IconButton(
                                                                                          icon: const Icon(
                                                                                            Icons
                                                                                                .chevron_left_outlined,
                                                                                            color: kPrimaryColor,
                                                                                            size: 35,
                                                                                          ),
                                                                                          onPressed: () {
                                                                                            print(
                                                                                                "Button pressed");
                                                                                            Navigator.pop(
                                                                                                context);
                                                                                          },
                                                                                        ),
                                                                                        Padding(
                                                                                          padding:
                                                                                          const EdgeInsets
                                                                                              .only(left: 10),
                                                                                          child: Text(
                                                                                            "$nameplace",
                                                                                            style: TextStyle(
                                                                                                color:
                                                                                                kPrimaryColor,
                                                                                                fontSize: 20),
                                                                                          ),
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
                                                                                    margin: EdgeInsets.only(
                                                                                        right: 20,
                                                                                        left: 20,
                                                                                        top: 20),
                                                                                    child: Column(
                                                                                      mainAxisSize:
                                                                                      MainAxisSize.min,
                                                                                      children: <Widget>[
                                                                                        Container(
                                                                                          height: 200,
                                                                                          child: ListView.builder(
                                                                                            scrollDirection:
                                                                                            Axis.horizontal,
                                                                                            itemCount:
                                                                                            images.length,
                                                                                            itemBuilder:
                                                                                                (context, index) {
                                                                                              return Container(
                                                                                                width: 250,
                                                                                                child: Card(
                                                                                                  elevation: 4,
                                                                                                  shape:
                                                                                                  RoundedRectangleBorder(
                                                                                                    borderRadius:
                                                                                                    BorderRadius
                                                                                                        .circular(
                                                                                                        10.0),
                                                                                                  ),
                                                                                                  child:
                                                                                                  ClipRRect(
                                                                                                    borderRadius:
                                                                                                    BorderRadius
                                                                                                        .circular(
                                                                                                        10.0),
                                                                                                    child: Image
                                                                                                        .memory(
                                                                                                      images[
                                                                                                      index],
                                                                                                      fit: BoxFit
                                                                                                          .fitHeight,
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
                                                                                            height:
                                                                                            size.height * 0.1,
                                                                                            child: Card(
                                                                                              elevation: 5,
                                                                                              shape:
                                                                                              RoundedRectangleBorder(
                                                                                                borderRadius:
                                                                                                BorderRadius
                                                                                                    .circular(
                                                                                                    10.0),
                                                                                              ),
                                                                                              child: ListView(
                                                                                                children: <
                                                                                                    Widget>[
                                                                                                  Column(
                                                                                                    children: [
                                                                                                      Text(
                                                                                                        "Weather",
                                                                                                        style: TextStyle(
                                                                                                            color:
                                                                                                            kPrimaryColor,
                                                                                                            fontSize:
                                                                                                            20),
                                                                                                      ),
                                                                                                      Container(
                                                                                                        width: size
                                                                                                            .width *
                                                                                                            0.8,
                                                                                                        padding: const EdgeInsets
                                                                                                            .symmetric(
                                                                                                            horizontal:
                                                                                                            2,
                                                                                                            vertical:
                                                                                                            2),
                                                                                                        decoration:
                                                                                                        BoxDecoration(
                                                                                                          color:
                                                                                                          kgreycolor,
                                                                                                          borderRadius:
                                                                                                          BorderRadius.circular(29),
                                                                                                        ),
                                                                                                        child:
                                                                                                        Center(
                                                                                                          child:
                                                                                                          Padding(
                                                                                                            padding:
                                                                                                            const EdgeInsets.all(8.0),
                                                                                                            child:
                                                                                                            Row(
                                                                                                              mainAxisAlignment:
                                                                                                              MainAxisAlignment.spaceBetween,
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
                                                                                                                Icon(Icons.air),
                                                                                                                Text(
                                                                                                                  "${wind.toString()}",
                                                                                                                  style: TextStyle(
                                                                                                                    fontFamily: fontfamily,
                                                                                                                    fontWeight: FontWeight.w500,
                                                                                                                    color: kPrimaryColor,
                                                                                                                    fontSize: 20.0,
                                                                                                                  ),
                                                                                                                ),
                                                                                                                Text(" km/h"),
                                                                                                                SizedBox(width: 5.0),
                                                                                                                Text("◎"),
                                                                                                                Icon(Icons.opacity),
                                                                                                                Text("${humidity.toString()}",
                                                                                                                    style: TextStyle(
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
                                                                                                    padding: const EdgeInsets
                                                                                                        .only(
                                                                                                        left:
                                                                                                        30.0),
                                                                                                    child:
                                                                                                    ListTile(
                                                                                                      leading:
                                                                                                      CircleAvatar(
                                                                                                        child:
                                                                                                        Icon(
                                                                                                          Icons
                                                                                                              .location_on,
                                                                                                          color:
                                                                                                          kPrimaryColor,
                                                                                                        ),
                                                                                                        backgroundColor:
                                                                                                        korangeColor,
                                                                                                      ),
                                                                                                      title: Text(
                                                                                                        detailsResult != null &&
                                                                                                            detailsResult!.formattedAddress != null
                                                                                                            ? 'Address: ${detailsResult!.formattedAddress}'
                                                                                                            : "Address: null",
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
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
                                                                              )
                                                                            // DetailsPageBottomSheet(
                                                                            //   placeId:
                                                                            //       predictions[index].placeId.toString(),
                                                                            //   googlePlace: googlePlace,
                                                                            // ),
                                                                          );
                                                                        },
                                                                      );
                                                                    },
                                                                    child: Container(
                                                                      height: size.width * 0.28,
                                                                      width: size.width * 0.29,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(10),
                                                                          image: DecorationImage(
                                                                              image: AssetImage("assets/images/placeholderimage-2.jpg"),
                                                                              fit: BoxFit.cover)),
                                                                    ),
                                                                  ),
                                                                  Column(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(left: 8.0, top: 1.0),
                                                                        child: Container(
                                                                          height: size.width * 0.052,
                                                                          width: size.width * 0.5,
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.only(
                                                                                topLeft: Radius.circular(10),
                                                                                bottomLeft: Radius.circular(4),
                                                                                bottomRight: Radius.circular(4),
                                                                                topRight: Radius.circular(4),
                                                                              ),
                                                                              border: Border.all(width: 1.8, color: kPrimaryColor)),
                                                                          child: Center(
                                                                              child: Text(
                                                                                "DESTINATION",
                                                                                style: TextStyle(color: kPrimaryColor),
                                                                              )),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: size.width * 0.5,
                                                                        child: Column(
                                                                          children: [
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(left: 8.0, top: 15),
                                                                                  child: Text(
                                                                                    //TODO : change list name
                                                                                    // PlacesObject['day${index+1}']['places'][indexlistview]['Name'].toString()
                                                            PlacesObject['day${index+1}']['places'][indexlistview]['Name'].toString().length > 10
                                                            ? PlacesObject['day${index+1}']['places'][indexlistview]['Name'].toString().substring(0, 10) +
                                                            "..."
                                                                :PlacesObject['day${index+1}']['places'][indexlistview]['Name'].toString(),
                                                                                    style: TextStyle(color: kPrimaryColor,fontSize: size.width * 0.06),
                                                                                    textAlign: TextAlign.left,
                                                                                  ),
                                                                                ),
                                                                                InkWell(
                                                                                    onTap:(){
                                                                                      // NoteObject['day${index+1}']['notes'].removeAt(indexlistview);
                                                                                      setState(() {
                                                                                        PlacesObject['day${index+1}']['places'].removeAt(indexlistview);
                                                                                        markers.removeAt(indexlistview);
                                                                                      });
                                                                                    },

                                                                                    child: Icon(Icons.delete, color: Colors.red, size: 15))
                                                                              ],
                                                                            ),
                                                                            // Container(
                                                                            //   padding: const EdgeInsets.symmetric(
                                                                            //       horizontal: 2, vertical: 2),
                                                                            //   decoration: BoxDecoration(
                                                                            //     color: Colors.white,
                                                                            //     borderRadius: BorderRadius.circular(29),
                                                                            //   ),
                                                                            //   child: GestureDetector(
                                                                            //     onTap: () {
                                                                            //       Future.delayed(Duration.zero, () {
                                                                            //         Navigator.push(
                                                                            //           context,
                                                                            //           MaterialPageRoute(
                                                                            //             builder: (context) {
                                                                            //               return LoadingScreen();
                                                                            //             },
                                                                            //           ),
                                                                            //         );
                                                                            //       });
                                                                            //     },
                                                                            //     child: Row(
                                                                            //       children: [
                                                                            //         SizedBox(width: 3.0),
                                                                            //         Text(weatherIcon, style: TextStyle(
                                                                            //           fontSize: 15.0,
                                                                            //         ),),
                                                                            //         SizedBox(width: 2.0),
                                                                            //         Row(
                                                                            //           children: [
                                                                            //             Text(temp.toString(), style: TextStyle(
                                                                            //               fontFamily: fontfamily,
                                                                            //               fontWeight: FontWeight.w900,
                                                                            //               color: kPrimaryColor,
                                                                            //               fontSize: 20.0,
                                                                            //             ),
                                                                            //             ),
                                                                            //             SizedBox(width: 1.0),
                                                                            //             Column(
                                                                            //               crossAxisAlignment: CrossAxisAlignment.start,
                                                                            //               children: [
                                                                            //                 Container(
                                                                            //                   // decoration: kTempUnitBoxDecoration,
                                                                            //                   child: Text("O", style: TextStyle(
                                                                            //                     fontFamily: fontfamily,
                                                                            //                     fontWeight: FontWeight.w100,
                                                                            //                     color: kPrimaryColor,
                                                                            //                     fontSize: 10.0,
                                                                            //                     height: 1.0,
                                                                            //                   ),),
                                                                            //                 ),
                                                                            //                 Text(city, style: TextStyle(
                                                                            //                     fontFamily: fontfamily,
                                                                            //                     fontSize: 10.0,
                                                                            //                     color: kPrimaryColor
                                                                            //                 ),
                                                                            //                 ),
                                                                            //               ],
                                                                            //             ),
                                                                            //             SizedBox(width: 5.0),
                                                                            //           ],
                                                                            //         ),
                                                                            //       ],
                                                                            //     ),
                                                                            //   ),
                                                                            // ),
                                                                          ],
                                                                        ),
                                                                      )

                                                                      // Text("Place Name")
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                          }),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(top: 8.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Todos on day ${index + 1}",
                                                            style: TextStyle(
                                                                fontSize: 25, fontWeight: FontWeight.w600, color: kPrimaryColor),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              //TODO : Adding notes logic here
                                                              var titlesi = "";
                                                              var description = "";
                                                              var noteslistofdays=[];
                                                              print("Day number is ${index}");
                                                              print("List is before $noteslistofdays");
                                                              if(NoteObject.isNotEmpty) {

                                                                if(NoteObject.containsKey('day${index+1}')) {
                                                                  print("Object list of place is ${NoteObject['day${index+1}']['notes']}");
                                                                  noteslistofdays = NoteObject['day${index+1}']['notes'];
                                                                }
                                                              }
                                                              print("List is after $noteslistofdays");
                                                              print("I am pressedddd");
                                                              var lengthdescription;
                                                              var countingchars = "0";
                                                              // bool descriptionkeyboard = false;
                                                              TextEditingController titlecontroller = TextEditingController();
                                                              TextEditingController descriptioncontroller = TextEditingController();
                                                              showModalBottomSheet<void>(
                                                                  isScrollControlled: true,
                                                                  context: context,
                                                                  builder: (BuildContext context) {
                                                                    return BottomSheet(
                                                                      // isScrollControlled: true,
                                                                        onClosing: () {},
                                                                        builder: (BuildContext context) {
                                                                          return StatefulBuilder(
                                                                              builder: (BuildContext context, setState) {
                                                                                return Container(
                                                                                  // height: 300,
                                                                                  decoration: BoxDecoration(
                                                                                    color: CupertinoColors.white,
                                                                                    borderRadius: BorderRadius.only(
                                                                                      topLeft: Radius.circular(20),
                                                                                      topRight: Radius.circular(20),
                                                                                    ),
                                                                                  ),
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.min,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.all(8.0),
                                                                                        child: Container(
                                                                                            width: size.width * 0.2,
                                                                                            height: 5,
                                                                                            decoration: BoxDecoration(
                                                                                                color: korangeColor,
                                                                                                borderRadius: BorderRadius.circular(50))),
                                                                                      ),
                                                                                      Text(
                                                                                        'Add a Note',
                                                                                        style: TextStyle(
                                                                                            color: kPrimaryColor,
                                                                                            fontSize: 18,
                                                                                            fontWeight: FontWeight.w500),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsets.only(left: size.width * 0.1),
                                                                                        child: Align(
                                                                                          alignment: Alignment.centerLeft,
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
                                                                                      ),
                                                                                      Container(
                                                                                        margin: const EdgeInsets.symmetric(vertical: 5),
                                                                                        padding: const EdgeInsets.symmetric(
                                                                                            horizontal: 20, vertical: 2),
                                                                                        width: size.width * 0.8,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Color(0xFFF2F3F8),
                                                                                          borderRadius: BorderRadius.circular(15),
                                                                                        ),
                                                                                        child: TextField(
                                                                                          onChanged: (value){
                                                                                            titlesi = value;
                                                                                          },
                                                                                          controller: titlecontroller,
                                                                                          textInputAction: TextInputAction.next,
                                                                                          cursorColor: kPrimaryColor,
                                                                                          decoration: InputDecoration(
                                                                                            border: InputBorder.none,
                                                                                              hintText: "Ex. Good dinner sports in ISB"
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsets.only(left: size.width * 0.1),
                                                                                        child: Align(
                                                                                          alignment: Alignment.centerLeft,
                                                                                          child: Text(
                                                                                            "Description",
                                                                                            style: TextStyle(
                                                                                              color: kPrimaryColor,
                                                                                              fontWeight: FontWeight.normal,
                                                                                              fontSize: 15.0,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        margin: const EdgeInsets.only(top: 5, bottom: 10),
                                                                                        padding: const EdgeInsets.symmetric(
                                                                                            horizontal: 20, vertical: 1),
                                                                                        width: size.width * 0.8,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Color(0xFFF2F3F8),
                                                                                          borderRadius: BorderRadius.circular(15),
                                                                                        ),

                                                                                        child: TextField(
                                                                                          inputFormatters: [
                                                                                            LengthLimitingTextInputFormatter(1000)
                                                                                          ],
                                                                                          // maxLength: 160,
                                                                                          // maxLengthEnforcement:MaxLengthEnforcement() ,
                                                                                          // readOnly:descriptionkeyboard ,
                                                                                          controller: descriptioncontroller,
                                                                                          onChanged: (value) {
                                                                                            description = value;
                                                                                            lengthdescription = value;
                                                                                            setState(() {
                                                                                              countingchars =
                                                                                                  lengthdescription.length.toString();
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
                                                                                              hintText: "Ex. Taaha recommended Burger Fest in the F7 Markaz, Great Pizza of 14th Street."
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Text(
                                                                                        "$countingchars/1000 max",
                                                                                        style: TextStyle(
                                                                                          color: kPrimaryColor,
                                                                                          fontWeight: FontWeight.normal,
                                                                                          fontSize: 10.0,
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsets.only(
                                                                                            bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                        child: Container(
                                                                                          height: size.height * 0.07,
                                                                                          // color: CupertinoColors.black,
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            children: [
                                                                                              Padding(
                                                                                                padding: EdgeInsets.only(left: 18.0),
                                                                                                child: InkWell(
                                                                                                  onTap: () {
                                                                                                    setState(() {
                                                                                                      titlecontroller.text = "";
                                                                                                      descriptioncontroller.text = "";
                                                                                                      countingchars = "";
                                                                                                    });
                                                                                                  },
                                                                                                  child: Text(
                                                                                                    "Clear",
                                                                                                    style: TextStyle(
                                                                                                        color: kPrimaryColor,
                                                                                                        fontSize: 15,
                                                                                                        decoration: TextDecoration.underline),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Padding(
                                                                                                padding: const EdgeInsets.only(right: 18.0),
                                                                                                child: Container(
                                                                                                  width: size.width * 0.18,
                                                                                                  height: size.height * 0.04,
                                                                                                  decoration: BoxDecoration(
                                                                                                      color: kPrimaryColor,
                                                                                                      borderRadius:
                                                                                                      BorderRadius.circular(10)),
                                                                                                  child: TextButton(
                                                                                                    onPressed: () {
                                                                                                      noteslistofdays.add(
                                                                                                          {
                                                                                                            "Title":titlesi,
                                                                                                            "Description": description,
                                                                                                          });
                                                                                                      this.setState(() {
                                                                                                        NoteObject["day${index+1}"] = {
                                                                                                          "notes":noteslistofdays,
                                                                                                          "places": {}
                                                                                                        };
                                                                                                      });
                                                                                                      Navigator.pop(context);
                                                                                                      print("Days Places List is ${NoteObject}");
                                                                                                    },
                                                                                                    child: Text(
                                                                                                      "Save",
                                                                                                      style: TextStyle(color: korangeColor),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              )
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                );
                                                                              });
                                                                        });
                                                                  });
                                                            },
                                                            child: Icon(
                                                              Icons.add_circle,
                                                              size: size.width * 0.08,
                                                              color: kPrimaryColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SingleChildScrollView(
                                                    child: Container(
                                                      height: size.height * 0.564,
                                                      child: ListView.builder(
                                                          itemCount: NoteObject.isNotEmpty?NoteObject.containsKey('day${index+1}')?NoteObject['day${index+1}']['notes'].length:0:0,
                                                          itemBuilder: (BuildContext context, int indexlistview) {
                                                            return Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Container(
                                                                    height: size.width * 0.28,
                                                                    width: size.width * 0.29,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        image: DecorationImage(
                                                                            image: AssetImage("assets/images/placeholdernotes.jpg"),
                                                                            fit: BoxFit.cover)),
                                                                  ),
                                                                  Column(
                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(left: 8.0, top: 1.0),
                                                                        child: Container(
                                                                          height: size.width * 0.052,
                                                                          width: size.width * 0.5,
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.only(
                                                                                topLeft: Radius.circular(10),
                                                                                bottomLeft: Radius.circular(4),
                                                                                bottomRight: Radius.circular(4),
                                                                                topRight: Radius.circular(4),
                                                                              ),
                                                                              border: Border.all(width: 1.8, color: kPrimaryColor)),
                                                                          child: Center(
                                                                              child: Text(
                                                                                "NOTE",
                                                                                style: TextStyle(color: kPrimaryColor),
                                                                              )),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: size.width * 0.5,
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 8.0, top: 15),
                                                                              child: Column(
                                                                                children: [
                                                                                  Text(

                                                            NoteObject['day${index+1}']['notes'][indexlistview]['Title'].toString().length > 15
                                                            ? NoteObject['day${index+1}']['notes'][indexlistview]['Title'].toString().substring(0, 15) +
                                                            "..."
                                                                : NoteObject['day${index+1}']['notes'][indexlistview]['Title'].toString(),


                                                                                    // NoteObject['day${index+1}']['notes'][indexlistview]['Title'].toString(),
                                                                                    style: TextStyle(color: kPrimaryColor),
                                                                                    textAlign: TextAlign.left,
                                                                                  ),
                                                                                  Text(

                                                                                    NoteObject['day${index+1}']['notes'][indexlistview]['Description'].toString().length > 15
                                                                                        ? NoteObject['day${index+1}']['notes'][indexlistview]['Description'].toString().substring(0, 15) +
                                                                                        "..."
                                                                                        : NoteObject['day${index+1}']['notes'][indexlistview]['Description'].toString(),


                                                                                    // NoteObject['day${index+1}']['notes'][indexlistview]['Title'].toString(),
                                                                                    style: TextStyle(color: kPrimaryColor),
                                                                                    textAlign: TextAlign.left,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                InkWell(
                                                                                  onTap: () {
                                                                                    var lengthdescription;
                                                                                    var countingchars = "0";
                                                                                    // bool descriptionkeyboard = false;
                                                                                    //TODO : Adding a note item
                                                                                    TextEditingController titlecontroller =
                                                                                    TextEditingController();
                                                                                    TextEditingController descriptioncontroller =
                                                                                    TextEditingController();
                                                                                    var description ;
                                                                                    var title;
                                                                                    titlecontroller.text = NoteObject['day${index+1}']['notes'][indexlistview]['Title'].toString();
                                                                                    descriptioncontroller.text = NoteObject['day${index+1}']['notes'][indexlistview]['Description'].toString();
                                                                                    title = NoteObject['day${index+1}']['notes'][indexlistview]['Title'].toString();
                                                                                    description = NoteObject['day${index+1}']['notes'][indexlistview]['Description'].toString();
                                                                                    countingchars =NoteObject['day${index+1}']['notes'][indexlistview]['Description'].toString().length.toString();
                                                                                    showModalBottomSheet<void>(
                                                                                        isScrollControlled: true,
                                                                                        context: context,
                                                                                        builder: (BuildContext context) {
                                                                                          return BottomSheet(
                                                                                            // isScrollControlled: true,
                                                                                              onClosing: () {},
                                                                                              builder: (BuildContext context) {
                                                                                                return StatefulBuilder(builder:
                                                                                                    (BuildContext context, setState) {
                                                                                                  return Container(
                                                                                                    // height: 300,
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: CupertinoColors.white,
                                                                                                      borderRadius: BorderRadius.only(
                                                                                                        topLeft: Radius.circular(20),
                                                                                                        topRight: Radius.circular(20),
                                                                                                      ),
                                                                                                    ),
                                                                                                    child: Column(
                                                                                                      mainAxisSize: MainAxisSize.min,
                                                                                                      children: [
                                                                                                        Padding(
                                                                                                          padding:
                                                                                                          const EdgeInsets.all(8.0),
                                                                                                          child: Container(
                                                                                                              width: size.width * 0.2,
                                                                                                              height: 5,
                                                                                                              decoration: BoxDecoration(
                                                                                                                  color: korangeColor,
                                                                                                                  borderRadius:
                                                                                                                  BorderRadius
                                                                                                                      .circular(50))),
                                                                                                        ),
                                                                                                        Text(
                                                                                                          'Edit a Note',
                                                                                                          style: TextStyle(
                                                                                                              color: kPrimaryColor,
                                                                                                              fontSize: 18,
                                                                                                              fontWeight:
                                                                                                              FontWeight.w500),
                                                                                                        ),
                                                                                                        Padding(
                                                                                                          padding: EdgeInsets.only(
                                                                                                              left: size.width * 0.1),
                                                                                                          child: Align(
                                                                                                            alignment:
                                                                                                            Alignment.centerLeft,
                                                                                                            child: Text(
                                                                                                              "Title",
                                                                                                              style: TextStyle(
                                                                                                                color: kPrimaryColor,
                                                                                                                fontWeight:
                                                                                                                FontWeight.normal,
                                                                                                                fontSize: 15.0,
                                                                                                              ),
                                                                                                              textAlign: TextAlign.left,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Container(
                                                                                                          margin:
                                                                                                          const EdgeInsets.symmetric(
                                                                                                              vertical: 5),
                                                                                                          padding:
                                                                                                          const EdgeInsets.symmetric(
                                                                                                              horizontal: 20,
                                                                                                              vertical: 2),
                                                                                                          width: size.width * 0.8,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: Color(0xFFF2F3F8),
                                                                                                            borderRadius:
                                                                                                            BorderRadius.circular(15),
                                                                                                          ),
                                                                                                          child: TextField(
                                                                                                            onChanged: (value){
                                                                                                              title = value;
                                                                                                            },
                                                                                                            controller: titlecontroller,
                                                                                                            textInputAction:
                                                                                                            TextInputAction.next,
                                                                                                            cursorColor: kPrimaryColor,
                                                                                                            decoration: InputDecoration(
                                                                                                              border: InputBorder.none,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Padding(
                                                                                                          padding: EdgeInsets.only(
                                                                                                              left: size.width * 0.1),
                                                                                                          child: Align(
                                                                                                            alignment:
                                                                                                            Alignment.centerLeft,
                                                                                                            child: Text(
                                                                                                              "Description",
                                                                                                              style: TextStyle(
                                                                                                                color: kPrimaryColor,
                                                                                                                fontWeight:
                                                                                                                FontWeight.normal,
                                                                                                                fontSize: 15.0,
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Container(
                                                                                                          margin: const EdgeInsets.only(
                                                                                                              top: 5, bottom: 10),
                                                                                                          padding:
                                                                                                          const EdgeInsets.symmetric(
                                                                                                              horizontal: 20,
                                                                                                              vertical: 1),
                                                                                                          width: size.width * 0.8,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: Color(0xFFF2F3F8),
                                                                                                            borderRadius:
                                                                                                            BorderRadius.circular(15),
                                                                                                          ),
                                                                                                          child: TextField(
                                                                                                            inputFormatters: [
                                                                                                              LengthLimitingTextInputFormatter(
                                                                                                                  1000)
                                                                                                            ],
                                                                                                            // maxLength: 160,
                                                                                                            // maxLengthEnforcement:MaxLengthEnforcement() ,
                                                                                                            // readOnly:descriptionkeyboard ,
                                                                                                            controller:
                                                                                                            descriptioncontroller,
                                                                                                            onChanged: (value) {
                                                                                                              lengthdescription = value;
                                                                                                              description = value;
                                                                                                              setState(() {
                                                                                                                countingchars =
                                                                                                                    lengthdescription
                                                                                                                        .length
                                                                                                                        .toString();
                                                                                                                // if(countingchars.length == 160){
                                                                                                                //   // descriptionkeyboard = true;
                                                                                                                // }
                                                                                                              });
                                                                                                            },
                                                                                                            keyboardType:
                                                                                                            TextInputType.multiline,
                                                                                                            maxLines: 4,
                                                                                                            textInputAction:
                                                                                                            TextInputAction.newline,
                                                                                                            cursorColor: kPrimaryColor,
                                                                                                            decoration: InputDecoration(
                                                                                                              border: InputBorder.none,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Text(
                                                                                                          "$countingchars/1000 max",
                                                                                                          style: TextStyle(
                                                                                                            color: kPrimaryColor,
                                                                                                            fontWeight: FontWeight.normal,
                                                                                                            fontSize: 10.0,
                                                                                                          ),
                                                                                                        ),
                                                                                                        Padding(
                                                                                                          padding: EdgeInsets.only(
                                                                                                              bottom:
                                                                                                              MediaQuery.of(context)
                                                                                                                  .viewInsets
                                                                                                                  .bottom),
                                                                                                          child: Container(
                                                                                                            height: size.height * 0.07,
                                                                                                            // color: CupertinoColors.black,
                                                                                                            child: Row(
                                                                                                              mainAxisAlignment:
                                                                                                              MainAxisAlignment
                                                                                                                  .spaceBetween,
                                                                                                              children: [
                                                                                                                Padding(
                                                                                                                  padding:
                                                                                                                  EdgeInsets.only(
                                                                                                                      left: 18.0),
                                                                                                                  child: InkWell(
                                                                                                                    onTap: () {
                                                                                                                      setState(() {
                                                                                                                        descriptioncontroller
                                                                                                                            .text = "";
                                                                                                                        countingchars =
                                                                                                                        "";
                                                                                                                      });
                                                                                                                    },
                                                                                                                    child: Text(
                                                                                                                      "Clear",
                                                                                                                      style: TextStyle(
                                                                                                                          color:
                                                                                                                          kPrimaryColor,
                                                                                                                          fontSize: 15,
                                                                                                                          decoration:
                                                                                                                          TextDecoration
                                                                                                                              .underline),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                Padding(
                                                                                                                  padding:
                                                                                                                  const EdgeInsets
                                                                                                                      .only(
                                                                                                                      right: 18.0),
                                                                                                                  child: Container(
                                                                                                                    width:
                                                                                                                    size.width * 0.18,
                                                                                                                    height: size.height *
                                                                                                                        0.04,
                                                                                                                    decoration: BoxDecoration(
                                                                                                                        color:
                                                                                                                        kPrimaryColor,
                                                                                                                        borderRadius:
                                                                                                                        BorderRadius
                                                                                                                            .circular(
                                                                                                                            10)),
                                                                                                                    child: TextButton(
                                                                                                                      onPressed: () {
                                                                                                                        //TODO:Update logic goes here
                                                                                                                        // noteslistofdays.add(
                                                                                                                        //     {
                                                                                                                        //       "Title":titlesi,
                                                                                                                        //       "Description": description,
                                                                                                                        //     });

                                                                                                                        this.setState(() {
                                                                                                                          NoteObject['day${index+1}']['notes'][indexlistview] = {
                                                                                                                            "Title":title,
                                                                                                                            "Description": description,
                                                                                                                          };
                                                                                                                        });
                                                                                                                        Navigator.pop(context);


                                                                                                                      },
                                                                                                                      child: Text(
                                                                                                                        "Update",
                                                                                                                        style: TextStyle(
                                                                                                                            color:
                                                                                                                            korangeColor),
                                                                                                                      ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                )
                                                                                                              ],
                                                                                                            ),
                                                                                                          ),
                                                                                                        )
                                                                                                      ],
                                                                                                    ),
                                                                                                  );
                                                                                                });
                                                                                              });
                                                                                        });
                                                                                  },
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child:
                                                                                    Icon(Icons.edit, color: korangeColor, size: 15),
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.circular(50)),
                                                                                  child: InkWell(
                                                                                    onTap:(){
                                                                                      setState(() {
                                                                                        print("List of notes is ${NoteObject['day${index+1}']['notes']}");
                                                                                        NoteObject['day${index+1}']['notes'].removeAt(indexlistview);
                                                                                      });
                                                                                    },
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child:
                                                                                      Icon(Icons.delete, color: Colors.red, size: 15),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )
                                                                          ],
                                                                        ),
                                                                      )

                                                                      // Text("Place Name")
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            );
                                                          }),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(top: 8.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Expenses ",
                                                            style: TextStyle(
                                                                fontSize: 25, fontWeight: FontWeight.w600, color: kPrimaryColor),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              showDialog(
                                                                  barrierDismissible: false,
                                                                  context: context,
                                                                  builder: (BuildContext context) {
                                                                    return StatefulBuilder(
                                                                      builder: (BuildContext context, setState) {
                                                                        return AlertDialog(
                                                                          backgroundColor: Colors.white,
                                                                          title: Text(
                                                                            'NEW TRANSACTION',
                                                                            textAlign: TextAlign.center,
                                                                            style: TextStyle(color: kPrimaryColor),
                                                                          ),
                                                                          content: SingleChildScrollView(
                                                                            child: Column(
                                                                              children: [
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                  children: [
                                                                                    Text(
                                                                                      'Expense',
                                                                                      style: TextStyle(color: korangeColor),
                                                                                    ),
                                                                                    Switch(
                                                                                      activeColor: kPrimaryColor,
                                                                                      inactiveTrackColor: Colors.grey,
                                                                                      inactiveThumbColor: korangeColor,
                                                                                      value: _isIncome,
                                                                                      onChanged: (newValue) {
                                                                                        setState(() {
                                                                                          _isIncome = newValue;
                                                                                        });
                                                                                      },
                                                                                    ),
                                                                                    Text(
                                                                                      'Income',
                                                                                      style: TextStyle(color: kPrimaryColor),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 5,
                                                                                ),
                                                                                Row(
                                                                                  children: [
                                                                                    Expanded(
                                                                                      child: Form(
                                                                                        key: _formKey,
                                                                                        child: TextFormField(
                                                                                          key: ValueKey("amount"),
                                                                                          keyboardType: TextInputType.number,
                                                                                          cursorColor: kPrimaryColor,
                                                                                          decoration: InputDecoration(
                                                                                              hintText: 'Enter Amount',
                                                                                              focusedBorder: OutlineInputBorder(
                                                                                                borderSide: const BorderSide(
                                                                                                    color: korangeColor, width: 2.0),
                                                                                                //borderRadius: BorderRadius.circular(25.0),
                                                                                              ),
                                                                                              border: OutlineInputBorder(
                                                                                                  borderSide: new BorderSide(
                                                                                                      color: kPrimaryColor))),
                                                                                          validator: (text) {
                                                                                            if (text == null || text.isEmpty) {
                                                                                              return 'Enter an amount';
                                                                                            }
                                                                                            return null;
                                                                                          },
                                                                                          controller: _textcontrollerAMOUNT,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 5,
                                                                                ),
                                                                                Row(
                                                                                  children: [
                                                                                    Expanded(
                                                                                      child: TextField(
                                                                                        key: ValueKey("description"),
                                                                                        cursorColor: kPrimaryColor,
                                                                                        decoration: InputDecoration(
                                                                                          hintText: 'For what',
                                                                                          focusedBorder: OutlineInputBorder(
                                                                                            borderSide: const BorderSide(
                                                                                                color: korangeColor, width: 2.0),
                                                                                            //borderRadius: BorderRadius.circular(25.0),
                                                                                          ),
                                                                                          border: OutlineInputBorder(
                                                                                            borderSide: BorderSide(color: kPrimaryColor),
                                                                                          ),
                                                                                        ),
                                                                                        controller: _textcontrollerITEM,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          actions: <Widget>[
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                              children: [
                                                                                MaterialButton(
                                                                                  disabledColor: korangeColor,
                                                                                  color: kPrimaryColor,
                                                                                  child: Text('Cancel',
                                                                                      style: TextStyle(color: Colors.white)),
                                                                                  onPressed: () {
                                                                                    Navigator.of(context).pop();
                                                                                  },
                                                                                ),
                                                                                MaterialButton(
                                                                                  color: kPrimaryColor,
                                                                                  child: Text('Enter',
                                                                                      style: TextStyle(color: Colors.white)),
                                                                                  onPressed: () async {
                                                                                    var id = widget.userid;
                                                                                    String value = _textcontrollerAMOUNT.text;
                                                                                    String description = _textcontrollerITEM.text;
                                                                                    http.Response response = await http.post(
                                                                                        Uri.parse(
                                                                                            "http://$urlmongo/tourists/create/expense/$id"),
                                                                                        body: {
                                                                                          'expense': _isIncome ? "0" : value,
                                                                                          'income': _isIncome ? value : "0",
                                                                                          'description': description
                                                                                        });
                                                                                    if (response.statusCode == 200) {
                                                                                      Navigator.of(context).pop();

                                                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                                                        const SnackBar(
                                                                                          duration: Duration(milliseconds: 1000),
                                                                                          backgroundColor: kPrimaryColor,
                                                                                          content: Text(
                                                                                            // "Password is not matched and Email is not correct",
                                                                                            "Expense add successfully",
                                                                                            style: TextStyle(
                                                                                                color: korangeColor,
                                                                                                fontWeight: FontWeight.bold,
                                                                                                fontFamily: fontfamily),
                                                                                            textAlign: TextAlign.center,
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                      _textcontrollerITEM.clear();
                                                                                      _textcontrollerAMOUNT.clear();
                                                                                    } else {
                                                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                                                        const SnackBar(
                                                                                          duration: Duration(milliseconds: 1000),
                                                                                          backgroundColor: kPrimaryColor,
                                                                                          content: Text(
                                                                                            // "Password is not matched and Email is not correct",
                                                                                            "Something Wrong Happens",
                                                                                            style: TextStyle(
                                                                                                color: korangeColor,
                                                                                                fontWeight: FontWeight.bold,
                                                                                                fontFamily: fontfamily),
                                                                                            textAlign: TextAlign.center,
                                                                                          ),
                                                                                        ),
                                                                                      );
                                                                                    }

                                                                                    // if (_formKey.currentState!.validate()) {
                                                                                    //   _enterTran  saction();
                                                                                    //   Navigator.of(context).pop();
                                                                                    // }
                                                                                  },
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    );
                                                                  });
                                                              // foraddingexpense.newTransaction();
                                                            },
                                                            child: Icon(
                                                              Icons.add_circle,
                                                              size: size.width * 0.08,
                                                              color: kPrimaryColor,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: size.height * 0.564,
                                                    child: Center(
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          Expanded(
                                                            child: ListView.builder(
                                                                itemCount: count,
                                                                itemBuilder: (context, index) {
                                                                  if ((data[index]['expense']) == 0) {
                                                                    money = (data[index]['income']);
                                                                    check = 'income';
                                                                  } else {
                                                                    money = (data[index]['expense']);
                                                                    check = 'expense';
                                                                  }
                                                                  return
                                                                    //   TransactionsforTrip(
                                                                    //   userid: widget.userid,
                                                                    //   transactionid: data[index]['id'],
                                                                    //   transactionName: data[index]['description'],
                                                                    //   money: '$money',
                                                                    //   expenseOrIncome: '$check',
                                                                    // );
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(bottom: 10.0),
                                                                      child: ClipRRect(
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        child: Container(
                                                                          padding: EdgeInsets.symmetric(vertical: 15),
                                                                          color: Colors.grey[100],
                                                                          child: Row(
                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  SizedBox(
                                                                                    width: 10,
                                                                                  ),
                                                                                  Text(
                                                                                      (data[index]['description'].length > 20)
                                                                                          ? data[index]['description'].substring(0, 20) +
                                                                                          "..."
                                                                                          : data[index]['description'],
                                                                                      textAlign: TextAlign.left,
                                                                                      style: TextStyle(
                                                                                        fontSize: 16,
                                                                                        color: kPrimaryColor,
                                                                                      )),
                                                                                ],
                                                                              ),
                                                                              Align(
                                                                                alignment: Alignment.centerRight,
                                                                                child: Container(
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.only(right: 8.0),
                                                                                        child: Text(
                                                                                          money.toString() + ' Rs.',
                                                                                          textAlign: TextAlign.right,
                                                                                          style: TextStyle(
                                                                                            //fontWeight: FontWeight.bold,
                                                                                            fontSize: 16,
                                                                                            color: check == 'expense'
                                                                                                ? Colors.red
                                                                                                : Colors.green,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.only(right: 5),
                                                                                        child: GestureDetector(
                                                                                          onTap: () {
                                                                                            _newTransaction(
                                                                                                money,
                                                                                                data[index]['description'],
                                                                                                check,
                                                                                                data[index]['id']);
                                                                                          },
                                                                                          child: Icon(
                                                                                            Icons.edit,
                                                                                            color: kPrimaryColor,
                                                                                            size: 18,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.only(right: 5),
                                                                                        child: GestureDetector(
                                                                                          key: ValueKey("Delete"),
                                                                                          onTap: () async {
                                                                                            http.Response response = await http.delete(
                                                                                              Uri.parse(
                                                                                                  "http://$urlmongo/general/delete/expense/${data[index]['id']}"),
                                                                                            );
                                                                                            if (response.statusCode == 200) {
                                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                                const SnackBar(
                                                                                                  duration: Duration(milliseconds: 1000),
                                                                                                  backgroundColor: kPrimaryColor,
                                                                                                  content: Text(
                                                                                                    // "Password is not matched and Email is not correct",
                                                                                                    "Deleted Succesfully",
                                                                                                    style: TextStyle(
                                                                                                        color: korangeColor,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                        fontFamily: fontfamily),
                                                                                                    textAlign: TextAlign.center,
                                                                                                  ),
                                                                                                ),
                                                                                              );
                                                                                              // Navigator.pop(context);
                                                                                              // Future.delayed(Duration.zero, () {
                                                                                              //   Navigator.push(
                                                                                              //     context,
                                                                                              //     MaterialPageRoute(
                                                                                              //       builder: (context) {
                                                                                              //         return TrackExpenses(
                                                                                              //           userid: widget.userid,
                                                                                              //         );
                                                                                              //       },
                                                                                              //     ),
                                                                                              //   );
                                                                                              // });
                                                                                              setState(() {
                                                                                                getdata();
                                                                                              });

                                                                                              // pushNewScreen(
                                                                                              //   context,
                                                                                              //   screen: TrackExpenses(userid: userid,),
                                                                                              //   withNavBar: true, // OPTIONAL VALUE. True by default.
                                                                                              // );
                                                                                            } else {
                                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                                const SnackBar(
                                                                                                  duration: Duration(milliseconds: 1000),
                                                                                                  backgroundColor: kPrimaryColor,
                                                                                                  content: Text(
                                                                                                    // "Password is not matched and Email is not correct",
                                                                                                    "Something went wrong",
                                                                                                    style: TextStyle(
                                                                                                        color: korangeColor,
                                                                                                        fontWeight: FontWeight.bold,
                                                                                                        fontFamily: fontfamily),
                                                                                                    textAlign: TextAlign.center,
                                                                                                  ),
                                                                                                ),
                                                                                              );
                                                                                            }
                                                                                          },
                                                                                          child: Icon(
                                                                                            Icons.delete,
                                                                                            color: Colors.red,
                                                                                            size: 18,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                }),
                                                          )
                                                          // Expanded(
                                                          //   child: GoogleSheetsApi.loading == true
                                                          //       ? LoadingCircle()
                                                          //       : ListView.builder(
                                                          //           itemCount:
                                                          //               GoogleSheetsApi.currentTransactions.length,
                                                          //           itemBuilder: (context, index) {
                                                          //             return MyTransaction(
                                                          //               transactionName: GoogleSheetsApi
                                                          //                   .currentTransactions[index][0],
                                                          //               money: GoogleSheetsApi
                                                          //                   .currentTransactions[index][1],
                                                          //               expenseOrIncome: GoogleSheetsApi
                                                          //                   .currentTransactions[index][2],
                                                          //             );
                                                          //           }),
                                                          // )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Text("No days added",
                    style:TextStyle(
                      color:korangeColor,
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.bold
                    ))
                    // daywidget,
                    //   //       //   InkWell(
                    //   //       //   onTap: () {
                    //   //       //     print("Length is ");
                    //   //       //     print(tabslist.length);
                    //   //       //   },
                    //   //       //   child: FittedBox(
                    //   //       //     fit: BoxFit.contain,
                    //   //       //     child: Container(
                    //   //       //       height: size.height * 0.05,
                    //   //       //       decoration: BoxDecoration(
                    //   //       //         color: kPrimaryColor,
                    //   //       //         borderRadius:
                    //   //       //         BorderRadius.circular(20),
                    //   //       //       ),
                    //   //       //       child: Center(
                    //   //       //         child: Row(
                    //   //       //           children: <Widget>[
                    //   //       //             Padding(
                    //   //       //               padding: EdgeInsets.only(
                    //   //       //                 right: size.width * 0.025,
                    //   //       //               ),
                    //   //       //               child: Text(
                    //   //       //                 "Day $index",
                    //   //       //                 style: TextStyle(
                    //   //       //                     color: Colors.white),
                    //   //       //               ),
                    //   //       //             ),
                    //   //       //           ],
                    //   //       //         ),
                    //   //       //       ),
                    //   //       //     ),
                    //   //       //   ),
                    //   //       // );
                    //       },
                    //     ),
                    //   ),
                    // ),
                    // Container(
                    //   child: SingleChildScrollView(
                    //     child: Column(
                    //       children: [
                    //         Center(child: Text("Day"))
                    //       ],
                    //     ),
                    //   ),
                    // )
                    // Flexible(
                    //   child: TabBar(
                    //     controller: _tabController,
                    //     tabs: myTabs,
                    //   ),
                    // ),
                  ]),
                )
                // Row(
                //   children: [
                //     Text(
                //       widget.name,
                //       style: TextStyle(
                //         fontSize: 50,
                //         color: kPrimaryColor
                //       ),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.only(left:8.0,top: 30),
                //       child: Text("0 items",
                //       style: TextStyle(
                //       fontSize: 10,
                //       color: kPrimaryColor
                //       ),),
                //     ),])
                ),
          ],
        ),
      ),
      // floatingActionButton:
      // floatingActionButton:
    );
  }

  WeatherModel model = WeatherModel();
  late int temp = 0;
  late var wind = 0.0;
  late var humidity = 0;
  late String city = '', weatherIcon = '0';
  dynamic data;
  late final String placeId;
  // late final GooglePlace googlePlace2;
  late final List<GooglePlace> selectedplaces = [];

  // var ontap;
  // _DetailsPageBottomSheetState(this.placeId, this.googlePlace, this.ontap);
  DetailsResult? detailsResult;
  List<Uint8List> images = [];
  // detailsResult.
  Future<void> getweatherdata(StateSetter setState) async {
    data = await NetworkHelper(
      "$kOwmUrl?lat=${detailsResult!.geometry!.location!.lat}&lon=${detailsResult!.geometry!.location!.lng}",
    ).getData();

    updateUI(setState);
  }

  void updateUI(StateSetter setState) async {
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
      humidity = (data["main"]["humidity"] as int).floor();
      wind = (data["wind"]["speed"] as double);
      city = data["name"];
    });
  }

  Future<void> getDetils(String placeId, StateSetter setState, BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Container(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(korangeColor),
            ),
          ),
        );
      },
    );
    var result = await googlePlace.details.get(placeId);
    // locationis = result!.result!.geometry!.location;
    if (result != null && result.result != null && mounted) {
      setState(() {
        detailsResult = result.result!;
        images = [];
      });
      if (images.length == 3) {
        return;
      }

      if (result.result!.photos != null) {
        for (var photo in result.result!.photos!) {
          // print("Photo Address is ${photo.photoReference.toString()}");
          await getPhoto(photo.photoReference.toString(), googlePlace);
        }
      }
    }
    await getweatherdata(setState);
  }

  String? nameplace;
  // Future<dynamic> getLocationData() async {
  //   WeatherModel model = WeatherModel();
  //   widget.locationWeather = await getLocationWeather();
  // }

  Future<void> getPhoto(String photoReference, GooglePlace placed) async {
    if (images.length == 3) {
      return;
    }
    var result = await placed.photos.get(photoReference, 20, 400);
    if (result != null && mounted) {
      setState(() {
        images.add(result);
      });
    }
  }

  dynamic totalIncome = '0';
  dynamic totalExpense = '0';
  dynamic balance = '0';
  dynamic expenseId;
  dynamic description;
  dynamic income;
  dynamic expense;
  int money = 0;
  dynamic check;
  // dynamic data;
  void getdata() async {
    var decodeData;
    var id = widget.userid;
    http.Response response = await http.get(Uri.parse("http://$urlmongo/tourists/expense/balance/$id"));
    if (response.statusCode == 200) {
      String data = response.body;
      print("Response Data $data");
      decodeData = jsonDecode(data);

      setState(() {
        // expenseId = decodeData[0]['_id'];
        // // print("Test 1 $expenseId");
        totalIncome = decodeData[0]['total_income'];
        // print("Test 2 $totalIncome");
        totalExpense = decodeData[0]['total_expense'];
        // print("Test 3 $totalExpense");
        balance = decodeData[0]['balance'];
        // print("Test 4 $balance");
      });
      getlistofexpenses();
    }
  }

  int count = 0;
  void getlistofexpenses() async {
    var decodeData;
    var productMap;
    var id = widget.userid;
    http.Response response = await http.get(Uri.parse("http://$urlmongo/tourists/expense/$id"));
    if (response.statusCode == 200) {
      data = response.body;
      print("Response Data $data");
      decodeData = jsonDecode(data);
      var expences = decodeData['expenses'];
      // int.parse(b);
      var checkcount = (decodeData['counter'][0]['count']);
      print("Count is $checkcount");

      print("Decode Data $expences");
      print("Decode Data counter $count");
      print("Decode Data counter after int $count");

      setState(() {
        count = checkcount;
      });
      List dataingetdata = [];

      for (final i in expences) {
        productMap = {
          // "id": index,
          //     "title": "Name ",
          //     "subtitle": "This is the subtitle $index"
          'id': i['_id'],
          'description': i['description'],
          'income': i['income'],
          'expense': i['expense'],
        };

        dataingetdata.add(productMap);
      }

      print("Data is $dataingetdata");

      setState(() {
        data = dataingetdata;
      });
    }
  }

  void _newTransaction(money, transactionName, expenseOrIncome, transactionid) {
    final _textcontrollerAMOUNT = TextEditingController();
    final _textcontrollerITEM = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    bool _isIncome = false;
    _textcontrollerAMOUNT.text = money;
    _textcontrollerITEM.text = transactionName;
    var check = expenseOrIncome;
    // bool _isIncome = false;
    if (check == 'income') {
      _isIncome = true;
    } else {
      _isIncome = false;
    }

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: Text(
                  'Update TRANSACTION',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: kPrimaryColor),
                ),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Expense',
                            style: TextStyle(color: korangeColor),
                          ),
                          Switch(
                            activeColor: kPrimaryColor,
                            inactiveTrackColor: Colors.grey,
                            inactiveThumbColor: korangeColor,
                            value: _isIncome,
                            onChanged: (newValue) {
                              setState(() {
                                _isIncome = newValue;
                              });
                            },
                          ),
                          Text(
                            'Income',
                            style: TextStyle(color: kPrimaryColor),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                cursorColor: kPrimaryColor,
                                decoration: InputDecoration(
                                  hintText: 'Enter Amount',
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: korangeColor, width: 2.0),
                                    //borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: new BorderSide(color: kPrimaryColor),
                                  ),
                                ),
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Enter an amount';
                                  }
                                  return null;
                                },
                                controller: _textcontrollerAMOUNT,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              cursorColor: kPrimaryColor,
                              decoration: InputDecoration(
                                hintText: 'For what',
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: korangeColor, width: 2.0),
                                  //borderRadius: BorderRadius.circular(25.0),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(color: kPrimaryColor),
                                ),
                              ),
                              controller: _textcontrollerITEM,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MaterialButton(
                        disabledColor: korangeColor,
                        color: kPrimaryColor,
                        child: Text('Cancel', style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      MaterialButton(
                        color: kPrimaryColor,
                        child: Text('Update', style: TextStyle(color: Colors.white)),
                        onPressed: () async {
                          var id = transactionid;
                          String value = _textcontrollerAMOUNT.text;
                          String description = _textcontrollerITEM.text;
                          http.Response response = await http.put(Uri.parse("http://$urlmongo/general/update/expense/$id"),
                              body: {'expense': _isIncome ? "0" : value, 'income': _isIncome ? value : "0", 'description': description});
                          if (response.statusCode == 200) {
                            //Navigator.of(context).pop();

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(milliseconds: 1000),
                                backgroundColor: kPrimaryColor,
                                content: Text(
                                  // "Password is not matched and Email is not correct",
                                  "Expense updated successfully",
                                  style: TextStyle(color: korangeColor, fontWeight: FontWeight.bold, fontFamily: fontfamily),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                            setState(() {
                              getdata();
                            });
                            _textcontrollerITEM.clear();
                            _textcontrollerAMOUNT.clear();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(milliseconds: 1000),
                                backgroundColor: kPrimaryColor,
                                content: Text(
                                  // "Password is not matched and Email is not correct",
                                  "Something Wrong Happens",
                                  style: TextStyle(color: korangeColor, fontWeight: FontWeight.bold, fontFamily: fontfamily),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }

                          // if (_formKey.currentState!.validate()) {
                          //   _enterTran  saction();
                          //   Navigator.of(context).pop();
                          // }
                        },
                      )
                    ],
                  ),
                ],
              );
            },
          );
        });
  }

  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
