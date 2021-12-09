import 'package:flutter/material.dart';
import 'package:testing_app/constants.dart';

class TouristBottomNavigation extends StatefulWidget {
  const TouristBottomNavigation({Key? key}) : super(key: key);

  @override
  State createState() => _TouristBottomNavigationState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _TouristBottomNavigationState extends State<TouristBottomNavigation> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    Size size = MediaQuery.of(context).size;

    return Container(
      // decoration: const BoxDecoration(
      //   borderRadius: BorderRadiusDirectional.only(
      //     topStart: Radius.circular(50),
      //     topEnd: Radius.circular(50),
      //   ),
      // ),
      child: SizedBox(
        child: BottomNavigationBar(
          // type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: korangeColor.withOpacity(.70),
          // selectedFontSize: 14,
          // unselectedFontSize: 14,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 25,
                // color: korangeColor,
              ),
              label: 'Explore',
              //backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 25,
                // color: korangeColor,
              ),
              label: 'Search',
              //backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                size: 25,
                // color: korangeColor,
              ),
              label: 'Favourite',
              //backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.luggage,
                size: 25,
                // color: korangeColor,
              ),
              label: 'Tour',
              //backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.chat,
                size: 25,
                // color: korangeColor,
              ),
              label: 'Chat',
              //backgroundColor: Colors.white,
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
