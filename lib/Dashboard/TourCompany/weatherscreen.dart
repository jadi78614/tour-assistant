import 'package:flutter/material.dart';

import 'package:testing_app/constants.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            // top: size.height * 0.05,
            // left: size.width * 0.05,
            padding: EdgeInsets.only(top: size.height * 0.05,
                left: size.width * 0.05),
            child: Row(
              children: [
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
                  child: Text("Weather",style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 20
                  ),),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 2),
            width: size.width * 0.8,
            decoration: BoxDecoration(
              color: kPrimaryLightColor,
              borderRadius: BorderRadius.circular(29),
            ),
            child: TextField(
              onChanged: (value) {},
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(

                hintText: "Enter place name",
                border: InputBorder.none,
                suffixIcon: GestureDetector(
                  onTap: () {},
                  child: GestureDetector(
                    onTap: (){},
                    child: Icon(
                      Icons.search,
                      color: korangeColor,
                    ),
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
