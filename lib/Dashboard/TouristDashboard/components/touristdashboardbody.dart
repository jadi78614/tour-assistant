import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/Weather/screens/loading_screen.dart';
import 'package:testing_app/Weather/services/weather.dart';
import 'package:testing_app/Weather/utilities/constants.dart';
import 'package:testing_app/constants.dart';
import 'popularplacesview.dart';
import 'itemundersearchbar.dart';

class UserDashboardTourist extends StatefulWidget {
  late final locationWeather;

  UserDashboardTourist({Key? key, this.locationWeather})
      : super(key: key);

  @override
  State createState() => _UserDashboard();
}

class _UserDashboard extends State<UserDashboardTourist> {
  late dynamic data;
  @override
  void initState() {
    data = model.getLocationWeather();
    super.initState();
    // setState(() {
    //   if (data == null) {
    //     temp = 0;
    //     weatherIcon = "0";
    //     city = "";
    //   }
    // });
    updateUI(widget.locationWeather);

  }

  getLocationData() async {
    WeatherModel model = WeatherModel();
    widget.locationWeather = await model.getLocationWeather();
  }
  WeatherModel model = WeatherModel();
  late int temp=0;
  late String city='', weatherIcon='0';

  void updateUI(dynamic data) async{
    data = await model.getLocationWeather();
    setState(() {
      if (data == null) {
        temp = 0;
        weatherIcon = "0";
        city = "";
        return;
      }
      print("data $data");

      temp = (data["main"]["temp"] as double).floor();
      weatherIcon = model.getWeatherIcon(data["weather"][0]["id"]);
      city = data["name"];

    });
    //print("data $data");
  }

  // Future GetDataonStart() async {
  //   data = await model.getLocationWeather();
  //   dynamic checkdata = data;
  //   print("check Data is $checkdata");
  //   updateUI(data);
  // }

  @override
  Widget build(BuildContext context) {
    //updateUI(data);
    assert(debugCheckHasMediaQuery(context));
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: (25 / 414.0) * size.width,
            ),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                  child: Image.asset(
                    "assets/images/background2.jpg",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: size.height * 0.5,
                  ),
                ),
                Positioned(
                  top: size.height * 0.05,
                  left: size.width * 0.05,
                  child: Builder(builder: (context) {
                    return IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 35,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    );
                  }),
                ),
                Positioned(
                  top: size.height * 0.065,
                  right: size.width * 0.05,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 2, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(29),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Future.delayed(Duration.zero, () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return LoadingScreen();
                              },
                            ),
                          );
                        });
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 3.0),
                          Text(weatherIcon, style: TextStyle(
                            fontSize: 15.0,
                          ),),
                          SizedBox(width: 2.0),
                          Row(
                            children: [
                              Text(temp.toString(), style: TextStyle(
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
                                  Container(
                                    // decoration: kTempUnitBoxDecoration,
                                    child: Text("O", style: TextStyle(
                                      fontFamily: fontfamily,
                                      fontWeight: FontWeight.w100,
                                      color: kPrimaryColor,
                                      fontSize: 10.0,
                                      height: 1.0,
                                    ),),
                                  ),
                                  Text(city, style: TextStyle(
                                    fontFamily: fontfamily,
                                    fontSize: 10.0,
                                    color: kPrimaryColor
                                  ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 5.0),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text(
                      "Tourism",
                      style: TextStyle(
                        fontSize: (73 / 414.0) * size.width,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 0.5,
                      ),
                    ),
                    const Text(
                      "All you need for tour",
                      style: TextStyle(color: kPrimaryLightColor),
                    ),
                  ],
                ),
                Positioned(
                  bottom: size.height * 0.012,
                  //child: const SearchField(),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 62),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      onChanged: (value) {},
                      cursorColor: kPrimaryColor,
                      decoration: const InputDecoration(
                        hintText: "Search",
                        border: InputBorder.none,
                        suffixIcon: Icon(
                          Icons.search,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: size.height*0.03,
                // ),
                Positioned(
                  bottom: size.height * 0.02,
                  left: size.width * 0.08,
                  right: size.width * 0.08,
                  child: ItemUnderSearchBar(size: size),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.15,
          ),
          PopularPlacesView(size: size),
          SizedBox(
            height: size.height * 0.15,
          ),
          PopularPlacesView(size: size),

          // PopularPlaces(),
          // VerticalSpacing(),
          // TopTravelers(),
          // VerticalSpacing(),
        ],
      ),
    );
  }
}
