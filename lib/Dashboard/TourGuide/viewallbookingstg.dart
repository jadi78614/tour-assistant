import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flash/flash.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:testing_app/Booking/drivervehicledata.dart';
import 'package:testing_app/Booking/hotelbooking.dart';
import 'package:testing_app/Booking/loadbookingdata.dart';
import 'package:testing_app/Booking/touguideservicedtail.dart';
import 'package:testing_app/Dashboard/DriverDashboard/vehicledata.dart';
import 'package:testing_app/Dashboard/HotelDashboard/roomdata.dart';
import 'package:testing_app/Dashboard/TourCompany/packagesdata.dart';
import 'package:testing_app/Dashboard/TourGuide/touguidedata.dart';
import 'package:testing_app/Hotel/details.dart';
import 'package:testing_app/Hotel/hotelbooking.dart';
import 'package:testing_app/NetworkHandler/dataofusers.dart';
import 'package:testing_app/NetworkHandler/injecteddatatousers.dart';
// import 'package:testing_app/Dashboard/TouristDashboard/user_dashboard.dart';
import 'package:testing_app/Weather/screens/loading_screen.dart';
import 'package:testing_app/Weather/services/weather.dart';
// import 'package:testing_app/Weather/utilities/constants.dart';
import 'package:testing_app/constants.dart';
import 'package:testing_app/models/travelspot.dart';
// import '../getservicesdata.dart';
import 'package:testing_app/Booking/bookingmodel.dart';
import '../TouristDashboard/packagedetailspage.dart';
// import '../user_search.dart';
// import 'itemsundersearchbar_items.dart';
// import 'popularplacesview.dart';
import 'package:testing_app/Dashboard/TouristDashboard/components/itemsundersearchbar_items.dart';

class ViewAllBookingsHotels extends StatefulWidget {
  late final locationWeather;
  String id;
  Data data;
  ViewAllBookingsHotels({Key? key, this.locationWeather, required this.id, required this.data}) : super(key: key);

  @override
  State createState() => _UserDashboard();
}

class _UserDashboard extends State<ViewAllBookingsHotels> {
  late dynamic data;
  FocusNode searchfocusnode = FocusNode();

  loaddata() async {
    BookingDataLoad getdata = BookingDataLoad();
    // tourpackagesbookings = await getdata.gettoupackagesdata();
    // vehicleslist = await getdata.getdriversdata();
    List<BookingData> tourpackagesbookings = await getdata.GetRoomsBookingsHotelSide(widget.id,"hotel");

    setState(() {
      this.tourpackagesbookings=tourpackagesbookings;
    });
    // tourguideslist = await getdata.gettourguidedata();
    //
    // print("List is ${getdata.Getroomsdata(widget.id,"tourists")}");
    // print("List is ${getdata.Getroomsdata()}");
    // print("List is ${getdata.gettoupackagesdata()}");
    // print("List is ${getdata.gettourguidedata()}");
    // getdata.getdriversdata();
    // getdata.Getroomsdata();
    // getdata.gettoupackagesdata();
    // getdata.gettourguidedata();
  }

  LoadLocalStorageData() {}
  List<BookingData> tourpackagesbookings = [];
  String useris_search = "tourcompany";

  Future<void> _pullRefresh() async {
    BookingDataLoad getdata = BookingDataLoad();
    List<BookingData> tourpackagesbookings  = await getdata.GetRoomsBookingsTourCompanySide(widget.id,"tourcompany");

    setState(() {
      this.tourpackagesbookings=tourpackagesbookings;
    });
    // why use freshWords var? https://stackoverflow.com/a/52992836/2301224
  }

  @override
  void initState() {
    super.initState();
    changecolor(3);
    loaddata();
    controller = ScrollController();
  }

  void _scrollToTop() {
    // fabIsVisible= false;
    controller.animateTo(0, duration: const Duration(milliseconds: 600), curve: Curves.linear);
  }

  @override
  void dispose() {
    controller.dispose(); // dispose the controller
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  ScrollController controller = ScrollController();
  // controller.addListener(() {
  // setState(() {
  // fabIsVisible =
  // controller.position.userScrollDirection == ScrollDirection.forward;
  // });
  // });
  bool fabIsVisible = true;
  // ScrollController maincontroller = ScrollController();
  @override
  Widget build(BuildContext context) {
    // final data = context.dependOnInheritedWidgetOfExactType<Inheriteddata>()!.data;
    //updateUI(data);
    assert(debugCheckHasMediaQuery(context));
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.16),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white),
          child: Padding(
            // top: size.height * 0.05,
            // left: size.width * 0.05,
            padding: EdgeInsets.only(top: size.height * 0.05, left: size.width * 0.05),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        "Bookings",
                        style: TextStyle(
                            color: kPrimaryColor,fontSize: 20),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.refresh,
                        color: kPrimaryColor,
                        size: 25,
                      ),
                      onPressed:_pullRefresh,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      key: _key,
      floatingActionButton: fabIsVisible == false
          ? null
          : Container(
        child: Container(
          height: size.width * 0.1,
          child: FloatingActionButton(
            onPressed: _scrollToTop,
            child: const Icon(Icons.arrow_upward),
            foregroundColor: kPrimaryColor,
            backgroundColor: kgreycolor,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh:_pullRefresh,
        child: SingleChildScrollView(
          controller: controller,
          child: Column(
            children: [
              // Padding(
              //   padding: EdgeInsets.symmetric(
              //     horizontal: 0.05 * size.width,
              //   ),
              //   child: Column(
              //     children: [
              //       Row(
              //         children: [
              //           Text(
              //             "Bookings",
              //             style: TextStyle(
              //               fontWeight: FontWeight.bold,
              //               fontSize: 0.06 * size.width,
              //             ),
              //           ),
              //           const Spacer(),
              //           // GestureDetector(
              //           //   onTap: () {
              //           //     Future.delayed(Duration.zero, () {
              //           //       Navigator.push(
              //           //         context,
              //           //         MaterialPageRoute(
              //           //           builder: (context) {
              //           //             return HotelBookingPage();
              //           //           },
              //           //         ),
              //           //       );
              //           //     });
              //           //   },
              //           //   child: const Text("See All"),
              //           // ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: size.height * 0.02,
              // ),
              tourpackagesbookings.isNotEmpty
                  ? Container(
                child: Column(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 24),
                    //   child: Align(
                    //     alignment: Alignment.centerLeft,
                    //     child: Text(
                    //       'Popular Packages',
                    //       textAlign: TextAlign.left,
                    //       style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25, color: Colors.black),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // Container(
                    //   // margin: EdgeInsets.only(bottom: size.width*0.1),
                    //   height: size.width * 0.5,
                    //   width: double.infinity,
                    //   child: ListView.builder(
                    //     padding: EdgeInsets.symmetric(horizontal: 10),
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: tourpackagesbookings.length > 4 ? 4 : tourpackagesbookings.length,
                    //     itemBuilder: (BuildContext context, index) {
                    //       return Container(
                    //         margin: EdgeInsets.symmetric(horizontal: 12.0),
                    //         // height: size.width * 0.1,
                    //         width: size.width * 0.35,
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(20),
                    //           color: kgreycolor,
                    //           // boxShadow: [
                    //           //   BoxShadow(
                    //           //     color: Colors.black12,
                    //           //     offset: Offset(0.0, 4.0),
                    //           //     blurRadius: 10.0,
                    //           //   )
                    //           // ],
                    //         ),
                    //         child: InkWell(
                    //           onTap: (){
                    //             pushNewScreen(
                    //               context,
                    //               screen: ShowTripDetailsCustomer(
                    //                 tourpdata: tourpackagesbookings[index],
                    //                 data: widget.data,
                    //                 scheduledetails: tourpackagesbookings[index].schedule.toString(),
                    //                 name: tourpackagesbookings[index].title.toString(),
                    //                 Stringid: widget.id,
                    //
                    //               ),
                    //               withNavBar: false, // OPTIONAL VALUE. True by default.
                    //             );
                    //           },
                    //           child: Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: <Widget>[
                    //               Container(
                    //                 height: size.width * 0.23,
                    //                 width: size.width * 0.35,
                    //                 decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.only(
                    //                     topLeft: Radius.circular(20.0),
                    //                     topRight: Radius.circular(20.0),
                    //                   ),
                    //                   image: DecorationImage(
                    //                     image: false ? AssetImage("assets/images/placeholder.png") as ImageProvider<Object> : AssetImage("assets/images/placeholder.png"),
                    //                     fit: BoxFit.cover,
                    //                   ),
                    //                 ),
                    //               ),
                    //               Padding(
                    //                 padding: const EdgeInsets.only(left: 10, top: 10),
                    //                 child: Text(
                    //                   tourpackagesbookings[index].title.toString(),
                    //                   style: TextStyle(fontSize: 14.0),
                    //                 ),
                    //               ),
                    //               Padding(
                    //                 padding: const EdgeInsets.only(left: 10),
                    //                 child: Text(
                    //                   tourpackagesbookings[index].description.toString(),
                    //                   style: TextStyle(fontSize: 13.0, color: Colors.grey),
                    //                 ),
                    //               ),
                    //               Padding(
                    //                 padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
                    //                 child: Row(
                    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                   children: <Widget>[
                    //                     Text(
                    //                       '\$${tourpackagesbookings[index].price} / night',
                    //                       style: TextStyle(color: korangeColor),
                    //                     ),
                    //                     Icon(
                    //                       Icons.favorite,
                    //                       color: Colors.grey[500],
                    //                       size: 16.0,
                    //                     )
                    //                   ],
                    //                 ),
                    //               )
                    //             ],
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 20.0,
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Hotel Bookings',
                            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: kPrimaryColor),
                          ),
                          // Text(
                          //   'view all',
                          //   style: TextStyle(fontSize: 18.0, color: kPrimaryColor),
                          // )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Column(
                      children: tourpackagesbookings.map((entry) {
                        return tourcompanyPackage(tourpackagesbookings.indexOf(entry), size);
                      }).toList(),
                      // [
                      //   tourcompanyPackage(0),
                      //   SizedBox(height: 20),
                      //   tourcompanyPackage(3),
                      //   SizedBox(height: 20),
                      //   tourcompanyPackage(0),
                      //   SizedBox(height: 20),
                      //   tourcompanyPackage(3),
                      // ],
                    )
                  ],
                )

              )
                  : Center(
                child: Container(
                  width: 40,
                  height: 40,
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(CupertinoColors.black),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  Widget tourcompanyPackage(int index, Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: 110,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: kgreycolor,
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black12,
          //     offset: Offset(0.0, 4.0),
          //     blurRadius: 10.0,
          //   )
          // ],
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 10,
              left: size.width * 0.1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Hotel Room",
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w800, color: Colors.black),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    tourpackagesbookings[index].Bookingid.toString(),
                    style: TextStyle(
                      fontSize: 14.0,
                      color: korangeColor,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'PKR ${tourpackagesbookings[index].amount} |',
                    style: TextStyle(fontSize: 16, color: kPrimaryColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color packagecolor = kPrimaryColor;
  String packagessearch = "selected";

  Color hotelcolor = korangeColor;
  String hotelsearch = "unselected";

  Color drivercolor = korangeColor;
  String driverssearch = "unselected";

  Color touguidescolor = korangeColor;
  String tourguidessearch = "unselected";
  String selecteddata_S = "packages";

  void changecolor(int selected) {
    if (selected == 2) {
      packagecolor = kPrimaryColor;
      hotelcolor = korangeColor;
      drivercolor = korangeColor;
      touguidescolor = korangeColor;
      selecteddata_S = "packages";
    }
    if (selected == 3) {
      packagecolor = korangeColor;
      hotelcolor = kPrimaryColor;
      drivercolor = korangeColor;
      touguidescolor = korangeColor;
      selecteddata_S = "hotels";
    }
    if (selected == 4) {
      packagecolor = korangeColor;
      hotelcolor = korangeColor;
      drivercolor = kPrimaryColor;
      touguidescolor = korangeColor;
      selecteddata_S = "drivers";
    }
    if (selected == 5) {
      packagecolor = korangeColor;
      hotelcolor = korangeColor;
      drivercolor = korangeColor;
      touguidescolor = kPrimaryColor;
      selecteddata_S = "tourguides";
    }
  }
}
