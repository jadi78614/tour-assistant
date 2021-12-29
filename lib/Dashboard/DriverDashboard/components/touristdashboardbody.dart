import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/constants.dart';
import 'popularplacesview.dart';
import 'itemundersearchbar.dart';


class UserDashboardDriver extends StatefulWidget {
  @override
  State createState() => _UserDashboard();
}

class _UserDashboard extends State<UserDashboardDriver> {
  @override
  Widget build(BuildContext context) {
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text(
                      "Drivers",
                      style: TextStyle(
                        fontSize: (73 / 414.0) * size.width,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 0.5,
                      ),
                    ),
                    const Text(
                      "Dashboard",
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


