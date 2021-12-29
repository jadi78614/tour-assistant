import 'package:flutter/material.dart';
import 'package:testing_app/constants.dart';
import 'itemsundersearchbar_items.dart';

class ItemUnderChatScreen extends StatefulWidget {
  const ItemUnderChatScreen({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<ItemUnderChatScreen> createState() => _ItemUnderChatScreenState();
}

class _ItemUnderChatScreenState extends State<ItemUnderChatScreen> {

  @override
  void initState() {
    changecolor(4);
    super.initState();
  }


  Color placescolor = korangeColor;
  Color packagecolor = korangeColor;
  Color hotelcolor = korangeColor;
  Color drivercolor = korangeColor;
  Color touguidescolor = korangeColor;

  // List<Color> listitems = [korangeColor,korangeColor,korangeColor,korangeColor,korangeColor]

  // int selected = 0;
  void changecolor(int selected) {
    if (selected == 1) {
      placescolor = kPrimaryColor;
      packagecolor = korangeColor;
      hotelcolor = korangeColor;
      drivercolor = korangeColor;
      touguidescolor = korangeColor;
    }
    if (selected == 2) {
      placescolor = korangeColor;
      packagecolor = kPrimaryColor;
      hotelcolor = korangeColor;
      drivercolor = korangeColor;
      touguidescolor = korangeColor;
    }
    if (selected == 3) {
      placescolor = korangeColor;
      packagecolor = korangeColor;
      hotelcolor = kPrimaryColor;
      drivercolor = korangeColor;
      touguidescolor = korangeColor;
    }
    if (selected == 4) {
      placescolor = korangeColor;
      packagecolor = korangeColor;
      hotelcolor = korangeColor;
      drivercolor = kPrimaryColor;
      touguidescolor = korangeColor;
    }
    if (selected == 5) {
      placescolor = korangeColor;
      packagecolor = korangeColor;
      hotelcolor = korangeColor;
      drivercolor = korangeColor;
      touguidescolor = kPrimaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          itemsundersearchbar_item(
            size: widget.size,
            icon: Icons.backpack,
            label: "Tour Company",
            color: packagecolor,
            onpress: () {
              setState(() {
                changecolor(2);
              });
            },
          ),
          SizedBox(
            width: widget.size.width * 0.02,
          ),
          itemsundersearchbar_item(
            size: widget.size,
            icon: Icons.hotel,
            label: "Hotels",
            color: hotelcolor,
            onpress: () {
              setState(() {
                changecolor(3);
              });
            },
          ),
          SizedBox(
            width: widget.size.width * 0.02,
          ),
          itemsundersearchbar_item(
            size: widget.size,
            icon: Icons.time_to_leave,
            label: "Drivers",
            color: drivercolor,
            onpress: () {
              setState(() {
                changecolor(4);
              });
            },
          ),
          SizedBox(
            width: widget.size.width * 0.02,
          ),
          itemsundersearchbar_item(
            size: widget.size,
            icon: Icons.hiking,
            label: "Tour Guides",
            color: touguidescolor,
            onpress: () {
              setState(() {
                changecolor(5);
              });
            },
          ),
        ],
      ),
    );
  }
}
