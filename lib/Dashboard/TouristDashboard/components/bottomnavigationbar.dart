import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:testing_app/Chat/chat.dart';
import 'package:testing_app/Dashboard/TouristDashboard/components/touristdashboardbody.dart';
import 'package:testing_app/Dashboard/TouristDashboard/user_booking.dart';
import 'package:testing_app/Dashboard/TouristDashboard/user_chat.dart';
import 'package:testing_app/Dashboard/TouristDashboard/user_search.dart';
import 'package:testing_app/Dashboard/TouristDashboard/user_wishlist.dart';
import 'package:testing_app/constants.dart';
//
// class TouristBottomNavigation extends StatefulWidget {
//   const TouristBottomNavigation({Key? key}) : super(key: key);
//
//   @override
//   State createState() => _TouristBottomNavigationState();
// }
//
// /// This is the private State class that goes with MyStatefulWidget.
// class _TouristBottomNavigationState extends State<TouristBottomNavigation> {
//   int _selectedIndex = 0;
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     assert(debugCheckHasMediaQuery(context));
//     Size size = MediaQuery.of(context).size;
//
//     return Container(
//       // decoration: const BoxDecoration(
//       //   borderRadius: BorderRadiusDirectional.only(
//       //     topStart: Radius.circular(50),
//       //     topEnd: Radius.circular(50),
//       //   ),
//       // ),
//       child: SizedBox(
//         child: BottomNavigationBar(
//           // type: BottomNavigationBarType.fixed,
//           backgroundColor: Colors.transparent,
//           selectedItemColor: kPrimaryColor,
//           unselectedItemColor: korangeColor.withOpacity(.70),
//           // selectedFontSize: 14,
//           // unselectedFontSize: 14,
//           items: <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.home,
//                 size: 25,
//                 // color: korangeColor,
//               ),
//               label: 'Explore',
//               //backgroundColor: Colors.white,
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.search,
//                 size: 25,
//                 // color: korangeColor,
//               ),
//               label: 'Search',
//               //backgroundColor: Colors.white,
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.favorite,
//                 size: 25,
//                 // color: korangeColor,
//               ),
//               label: 'Favourite',
//               //backgroundColor: Colors.white,
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.luggage,
//                 size: 25,
//                 // color: korangeColor,
//               ),
//               label: 'Tour',
//               //backgroundColor: Colors.white,
//             ),
//             BottomNavigationBarItem(
//               icon: GestureDetector(
//                 onTap: (){},
//                 child: Icon(
//                   Icons.chat,
//                   size: 25,
//                   // color: korangeColor,
//                 ),
//               ),
//               label: 'Chat',
//               //backgroundColor: Colors.white,
//             ),
//           ],
//           currentIndex: _selectedIndex,
//           onTap: _onItemTapped,
//         ),
//       ),
//     );
//   }
// }

PersistentTabController _controller = PersistentTabController(initialIndex: 0);


class TouristBottomNavigation extends StatelessWidget {
  String stringid ;

  TouristBottomNavigation({
    Key? key,
    required this.stringid
  }) : super(key: key);

  List<Widget> _buildScreens() {
    return [
      UserDashboardTourist(),
      SearchTourist(),
      WishlistTourist(),
      BookingTourist(),
      ChatTourist(stringid:stringid),

    ];
  }
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Explore"),
        activeColorPrimary: kPrimaryColor,
        inactiveColorPrimary: korangeColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.search),
        title: ("Search"),
        activeColorPrimary: kPrimaryColor,
        inactiveColorPrimary: korangeColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.favorite),
        title: ("Wishlist"),
        activeColorPrimary: kPrimaryColor,
        inactiveColorPrimary: korangeColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.luggage),
        title: ("Tours"),
        activeColorPrimary: kPrimaryColor,
        inactiveColorPrimary: korangeColor,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.chat),
        title: ("Chat"),
        activeColorPrimary: kPrimaryColor,
        inactiveColorPrimary: korangeColor,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    Size size = MediaQuery.of(context).size;
    return PersistentTabView(
      context,
      controller: _controller,
      navBarHeight:size.height*0.09,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        // borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}