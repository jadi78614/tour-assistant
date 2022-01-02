// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:testing_app/Dashboard/TouristDashboard/components/touristdashboarddrawer.dart';
import 'package:testing_app/Login/login_screen.dart';
import 'package:testing_app/main.dart';
import 'package:integration_test/integration_test.dart';

import 'package:testing_app/main.dart' as app;


// Widget createLoginScreen() => LoginScreen();

Widget loginScreen = MediaQuery(
    data: MediaQueryData(),
    child: MaterialApp(home: LoginScreen())
);

void main() {
//   group('Screens ', () {
//     testWidgets('Testing WelcomeScreen Having buttons and Texts', (WidgetTester tester) async {
//       // Build our app and trigger a frame.
//       await tester.pumpWidget(const MyApp());
//       expect(find.text('Let\'s Get Started'), findsOneWidget);
//       expect(find.text('Enjoy Every        '), findsOneWidget);
//       expect(find.text('Moment With Us '), findsOneWidget);
//       // await tester.pump();
//       await tester.tap(find.widgetWithText(ElevatedButton, "Let's Get Started"));
//       await tester.pump();
//       expect(find.text('Moment With Us '), findsOneWidget);
//
//     });
//
//   testWidgets('Testing LoginScreen Having buttons and Texts', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//
//     await tester.pumpWidget(loginScreen);
//     expect(find.text('Let\'s Get Started'), findsNothing);
//     // Expect to find the item on screen.
//     expect(find.byIcon(Icons.person), findsOneWidget);
//     //print("New widget is now placed");
//     // await tester.pump();
//   });
//
// });

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('welcome-to-addexpenses', () {
    testWidgets('Tap on lets go button and then enter the credentials and tap on'
        ' the login button and ask for the location permission, opens the drawer '
        'and tap on the currency converter and enter amount for converting and tap'
        ' on the convert button',
            (WidgetTester tester) async {

          app.main();
          // await Future.delayed(const Duration(seconds: 5), (){});
          await tester.pumpAndSettle(Duration(seconds: 5));

          // Verify the counter starts at 0.
          // expect(find.text('0'), findsOneWidget);
          expect(find.text('Enjoy Every        '), findsOneWidget);


          // Finds the floating action button to tap on.
          final Finder lgs_b = find.widgetWithText(ElevatedButton, "Let's Get Started");

          // Emulate a tap on the floating action button.
          await tester.tap(lgs_b);

          await tester.pumpAndSettle();

          // Verify the counter increments by 1.
          expect(find.text('Login '), findsOneWidget);

          // await tester.enterText(find.text("Username or Email"), 'ali@gmail.com');
          await tester.enterText(find.byKey(Key('username')), 'ali@gmail.com');
          await tester.enterText(find.byKey(Key('password')), '123456');
          // await tester.enterText(find.byType(TextField), '123456');

          final Finder login = find.widgetWithText(ElevatedButton, "LOGIN");


          bool serviceEnabled;
          LocationPermission permission;
          // Test if location services are enabled.
          serviceEnabled = await Geolocator.isLocationServiceEnabled();
          if (!serviceEnabled) {
            // Location services are not enabled don't continue
            // accessing the position and request users of the
            // App to enable the location services.
            return Future.error('Location services are disabled.');
          }
          permission = await Geolocator.checkPermission();
          if (permission == LocationPermission.denied) {
            permission = await Geolocator.requestPermission();
            if (permission == LocationPermission.denied) {
              // Permissions are denied, next time you could try
              // requesting permissions again (this is also where
              // Android's shouldShowRequestPermissionRationale
              // returned true. According to Android guidelines
              // your App should show an explanatory UI now.
              return Future.error('Location permissions are denied');
            }
          }
          if (permission == LocationPermission.deniedForever) {
            // Permissions are denied forever, handle appropriately.
            return Future.error(
                'Location permissions are permanently denied, we cannot request permissions.');
          }
          // Emulate a tap on the floating action button.
          await tester.tap(login);

          await Future.delayed(const Duration(seconds: 4), (){});



          await tester.pumpAndSettle(Duration(seconds: 4));
          // await Future.delayed(const Duration(seconds: 10), (){});

          final Finder drawer = find.byIcon(Icons.menu);

          await tester.tap(drawer);
          // Trigger a frame.
          await tester.pumpAndSettle();
          // await Future.delayed(const Duration(seconds: 5), (){});
          final Finder currencyconverter = find.text("Currency Converter");

          // Emulate a tap on the floating action button.
          await tester.tap(currencyconverter);

          // Trigger a frame.
          await tester.pumpAndSettle();
          // await Future.delayed(const Duration(seconds: 5), (){});



          await tester.enterText(find.byKey(ValueKey('amount')), '100');
          await tester.pumpAndSettle();
          // await Future.delayed(const Duration(seconds: 5), (){});
          await Future.delayed(const Duration(seconds: 5), (){});
          await tester.pumpAndSettle();
          final Finder convert = find.widgetWithText(ElevatedButton, "Convert");
          await tester.pumpAndSettle();
          await tester.tap(convert);
          await tester.pumpAndSettle();

          await Future.delayed(const Duration(seconds: 5), (){});

        });


    testWidgets('Tap on lets go button and then enter the credentials and tap on'
        ' the login button and ask for the location permission, opens the drawer '
        'and tap on the edit profile button and enter new city',
            (WidgetTester tester) async {
              await Future.delayed(const Duration(seconds: 4), (){});
              app.main();
              // await Future.delayed(const Duration(seconds: 5), (){});
              await tester.pumpAndSettle();

              // Verify the counter starts at 0.
              // expect(find.text('0'), findsOneWidget);
              expect(find.text('Enjoy Every        '), findsOneWidget);


              // Finds the floating action button to tap on.
              final Finder lgs_b = find.widgetWithText(ElevatedButton, "Let's Get Started");

              // Emulate a tap on the floating action button.
              await tester.tap(lgs_b);

              // Trigger a frame.
              await tester.pumpAndSettle();

              // Verify the counter increments by 1.
              expect(find.text('Login '), findsOneWidget);

              // await tester.enterText(find.text("Username or Email"), 'ali@gmail.com');
              await tester.enterText(find.byKey(Key('username')), 'ali@gmail.com');
              await tester.enterText(find.byKey(Key('password')), '123456');
              // await tester.enterText(find.byType(TextField), '123456');

              final Finder login = find.widgetWithText(ElevatedButton, "LOGIN");
              await tester.tap(login);

              // await Future.delayed(const Duration(seconds: 4), (){});
              await tester.pumpAndSettle(Duration(seconds: 4));
              // await Future.delayed(const Duration(seconds: 10), (){});

              final Finder drawer = find.byIcon(Icons.menu);

              await tester.tap(drawer);
              // Trigger a frame.
              await tester.pumpAndSettle();
              // await Future.delayed(const Duration(seconds: 5), (){});
              final Finder editprofile = find.widgetWithText(TextButton, "Edit Profile");

              // Emulate a tap on the floating action button.
              await tester.tap(editprofile);

              // Trigger a frame.
              await tester.pumpAndSettle();
              // await Future.delayed(const Duration(seconds: 5), (){});



              await tester.enterText(find.byKey(ValueKey('city')), 'Manitoba');
              await tester.pumpAndSettle();
              // await Future.delayed(const Duration(seconds: 5), (){});
              await Future.delayed(const Duration(seconds: 5), (){});
              await tester.pumpAndSettle();
              final Finder convert = find.widgetWithText(ElevatedButton, "Update Profile");
              await tester.pumpAndSettle();
              await tester.tap(convert);
              await tester.pumpAndSettle();

              // await Future.delayed(const Duration(seconds: 5), (){});

        });


    testWidgets('Tap on lets go button and then enter the credentials and tap on'
        ' the login button and ask for the location permission, opens the drawer '
        'and tap on the edit profile enter New Name',
            (WidgetTester tester) async {
              await Future.delayed(const Duration(seconds: 4), (){});
              app.main();
              // await Future.delayed(const Duration(seconds: 5), (){});
              await tester.pumpAndSettle();

              // Verify the counter starts at 0.
              // expect(find.text('0'), findsOneWidget);
              expect(find.text('Enjoy Every        '), findsOneWidget);


              // Finds the floating action button to tap on.
              final Finder lgs_b = find.widgetWithText(ElevatedButton, "Let's Get Started");

              // Emulate a tap on the floating action button.
              await tester.tap(lgs_b);

              // Trigger a frame.
              await tester.pumpAndSettle();

              // Verify the counter increments by 1.
              expect(find.text('Login '), findsOneWidget);

              // await tester.enterText(find.text("Username or Email"), 'ali@gmail.com');
              await tester.enterText(find.byKey(Key('username')), 'ali@gmail.com');
              await tester.enterText(find.byKey(Key('password')), '123456');
              // await tester.enterText(find.byType(TextField), '123456');

              final Finder login = find.widgetWithText(ElevatedButton, "LOGIN");

              await tester.tap(login);

              await Future.delayed(const Duration(seconds: 4), (){});

              await tester.pumpAndSettle(Duration(seconds: 4));
              // await Future.delayed(const Duration(seconds: 10), (){});

              final Finder drawer = find.byIcon(Icons.menu);

              await tester.tap(drawer);
              // Trigger a frame.
              await tester.pumpAndSettle();
              // await Future.delayed(const Duration(seconds: 5), (){});
              final Finder editprofile = find.widgetWithText(TextButton, "Edit Profile");

              // Emulate a tap on the floating action button.
              await tester.tap(editprofile);

              // Trigger a frame.
              await tester.pumpAndSettle();
              // await Future.delayed(const Duration(seconds: 5), (){});



              await tester.enterText(find.byKey(ValueKey('name')), 'Muhammad Muneeb');
              await tester.pumpAndSettle();
              // await Future.delayed(const Duration(seconds: 5), (){});
              await Future.delayed(const Duration(seconds: 5), (){});
              await tester.pumpAndSettle();
              final Finder convert = find.widgetWithText(ElevatedButton, "Update Profile");
              await tester.pumpAndSettle();
              await tester.tap(convert);
              await tester.pumpAndSettle();

              await Future.delayed(const Duration(seconds: 5), (){});

        });


    testWidgets('Tap on lets go button and then enter the credentials and tap on'
        ' the login button and ask for the location permission, opens the drawer '
        'and tap on the edit profile enter New address',
            (WidgetTester tester) async {
              await Future.delayed(const Duration(seconds: 4), (){});
              app.main();
              // await Future.delayed(const Duration(seconds: 5), (){});
              await tester.pumpAndSettle();

              // Verify the counter starts at 0.
              // expect(find.text('0'), findsOneWidget);
              expect(find.text('Enjoy Every        '), findsOneWidget);


              // Finds the floating action button to tap on.
              final Finder lgs_b = find.widgetWithText(ElevatedButton, "Let's Get Started");

              // Emulate a tap on the floating action button.
              await tester.tap(lgs_b);

              // Trigger a frame.
              await tester.pumpAndSettle();

              // Verify the counter increments by 1.
              expect(find.text('Login '), findsOneWidget);

              // await tester.enterText(find.text("Username or Email"), 'ali@gmail.com');
              await tester.enterText(find.byKey(Key('username')), 'ali@gmail.com');
              await tester.enterText(find.byKey(Key('password')), '123456');
              // await tester.enterText(find.byType(TextField), '123456');

              final Finder login = find.widgetWithText(ElevatedButton, "LOGIN");

              await tester.tap(login);

              await Future.delayed(const Duration(seconds: 4), (){});

              await tester.pumpAndSettle(Duration(seconds: 4));
              // await Future.delayed(const Duration(seconds: 10), (){});

              final Finder drawer = find.byIcon(Icons.menu);

              await tester.tap(drawer);
              // Trigger a frame.
              await tester.pumpAndSettle();
              // await Future.delayed(const Duration(seconds: 5), (){});
              final Finder editprofile = find.widgetWithText(TextButton, "Edit Profile");

              // Emulate a tap on the floating action button.
              await tester.tap(editprofile);

              // Trigger a frame.
              await tester.pumpAndSettle();
              // await Future.delayed(const Duration(seconds: 5), (){});



              await tester.enterText(find.byKey(ValueKey('address')), 'Park Road, Meharban Coloney Islamabad');
              await tester.pumpAndSettle();
              // await Future.delayed(const Duration(seconds: 5), (){});
              await Future.delayed(const Duration(seconds: 5), (){});
              await tester.pumpAndSettle();
              final Finder convert = find.widgetWithText(ElevatedButton, "Update Profile");
              await tester.pumpAndSettle();
              await tester.tap(convert);
              await tester.pumpAndSettle();

              await Future.delayed(const Duration(seconds: 5), (){});

        });

    testWidgets('Tap on lets go button and then enter the credentials and tap on'
        ' the login button and ask for the location permission, opens the drawer '
        'and tap on the edit profile enter New address',
            (WidgetTester tester) async {
              await Future.delayed(const Duration(seconds: 4), (){});
              app.main();
              // await Future.delayed(const Duration(seconds: 5), (){});
              await tester.pumpAndSettle();

              // Verify the counter starts at 0.
              // expect(find.text('0'), findsOneWidget);
              expect(find.text('Enjoy Every        '), findsOneWidget);


              // Finds the floating action button to tap on.
              final Finder lgs_b = find.widgetWithText(ElevatedButton, "Let's Get Started");

              // Emulate a tap on the floating action button.
              await tester.tap(lgs_b);

              // Trigger a frame.
              await tester.pumpAndSettle();

              // Verify the counter increments by 1.
              expect(find.text('Login '), findsOneWidget);

              // await tester.enterText(find.text("Username or Email"), 'ali@gmail.com');
              await tester.enterText(find.byKey(Key('username')), 'ali@gmail.com');
              await tester.enterText(find.byKey(Key('password')), '123456');
              // await tester.enterText(find.byType(TextField), '123456');

              final Finder login = find.widgetWithText(ElevatedButton, "LOGIN");

              await tester.tap(login);

              await Future.delayed(const Duration(seconds: 4), (){});

              await tester.pumpAndSettle(Duration(seconds: 4));
              // await Future.delayed(const Duration(seconds: 10), (){});

              final Finder drawer = find.byIcon(Icons.menu);

              await tester.tap(drawer);
              // Trigger a frame.
              await tester.pumpAndSettle();
              // await Future.delayed(const Duration(seconds: 5), (){});
              final Finder editprofile = find.widgetWithText(TextButton, "Edit Profile");

              // Emulate a tap on the floating action button.
              await tester.tap(editprofile);

              // Trigger a frame.
              await tester.pumpAndSettle();
              // await Future.delayed(const Duration(seconds: 5), (){});



              await tester.enterText(find.byKey(ValueKey('password')), '123456');
              await tester.pumpAndSettle();
              // await Future.delayed(const Duration(seconds: 5), (){});
              await Future.delayed(const Duration(seconds: 5), (){});
              await tester.pumpAndSettle();
              final Finder convert = find.widgetWithText(ElevatedButton, "Update Profile");
              await tester.pumpAndSettle();
              await tester.tap(convert);
              await tester.pumpAndSettle();

              await Future.delayed(const Duration(seconds: 5), (){});

        });

    testWidgets('Tap on lets go button and then enter the credentials and tap on'
        ' the login button and ask for the location permission, opens the drawer '
        'and tap on the add expenses',
            (WidgetTester tester) async {
              app.main();
              // await Future.delayed(const Duration(seconds: 5), (){});
              await tester.pumpAndSettle();

              // Verify the counter starts at 0.
              // expect(find.text('0'), findsOneWidget);
              expect(find.text('Enjoy Every        '), findsOneWidget);


              // Finds the floating action button to tap on.
              final Finder lgs_b = find.widgetWithText(ElevatedButton, "Let's Get Started");

              // Emulate a tap on the floating action button.
              await tester.tap(lgs_b);

              // Trigger a frame.
              await tester.pumpAndSettle();

              // Verify the counter increments by 1.
              expect(find.text('Login '), findsOneWidget);

              // await tester.enterText(find.text("Username or Email"), 'ali@gmail.com');
              await tester.enterText(find.byKey(Key('username')), 'ali@gmail.com');
              await tester.enterText(find.byKey(Key('password')), '123456');
              // await tester.enterText(find.byType(TextField), '123456');

              final Finder login = find.widgetWithText(ElevatedButton, "LOGIN");

              // Emulate a tap on the floating action button.
              await tester.tap(login);

              await Future.delayed(const Duration(seconds: 4), (){});



              await tester.pumpAndSettle(Duration(seconds: 4));
              // await Future.delayed(const Duration(seconds: 10), (){});

              final Finder drawer = find.byIcon(Icons.menu);

              await tester.tap(drawer);
              // Trigger a frame.
              await tester.pumpAndSettle();
              // await Future.delayed(const Duration(seconds: 5), (){});
              final Finder trackexpences = find.text("Track Expenses");

              // Emulate a tap on the floating action button.
              await tester.tap(trackexpences);

              // Trigger a frame.
              await tester.pumpAndSettle();
              // await Future.delayed(const Duration(seconds: 5), (){});

              final Finder addbutton = find.byKey(ValueKey('plussbuttion'));

              // Emulate a tap on the floating action button.
              await tester.tap(addbutton);

              // Trigger a frame.
              await tester.pumpAndSettle();
              // await Future.delayed(const Duration(seconds: 5), (){});



              await tester.enterText(find.byKey(ValueKey('amount')), '100');
              await tester.enterText(find.byKey(ValueKey('description')), 'adding through testing 100 rs');

              await tester.pumpAndSettle();
              // await Future.delayed(const Duration(seconds: 5), (){});
              await Future.delayed(const Duration(seconds: 5), (){});
              await tester.pumpAndSettle();
              final Finder convert = find.widgetWithText(MaterialButton, "Enter");
              await tester.pumpAndSettle();
              await tester.tap(convert);
              await tester.pumpAndSettle();

              await Future.delayed(const Duration(seconds: 5), (){});

        });



  });


  // testWidgets('Tap on lets go button and then enter the credentials and tap on'
  //     ' the login button and ask for the location permission, opens the drawer '
  //     'and tap on the delete expenses',
  //         (WidgetTester tester) async {
  //       app.main();
  //       // await Future.delayed(const Duration(seconds: 5), (){});
  //       await tester.pumpAndSettle();
  //
  //       // Verify the counter starts at 0.
  //       // expect(find.text('0'), findsOneWidget);
  //       expect(find.text('Enjoy Every        '), findsOneWidget);
  //
  //
  //       // Finds the floating action button to tap on.
  //       final Finder lgs_b = find.widgetWithText(ElevatedButton, "Let's Get Started");
  //
  //       // Emulate a tap on the floating action button.
  //       await tester.tap(lgs_b);
  //
  //       // Trigger a frame.
  //       await tester.pumpAndSettle();
  //
  //       // Verify the counter increments by 1.
  //       expect(find.text('Login '), findsOneWidget);
  //
  //       // await tester.enterText(find.text("Username or Email"), 'ali@gmail.com');
  //       await tester.enterText(find.byKey(Key('username')), 'ali@gmail.com');
  //       await tester.enterText(find.byKey(Key('password')), '123456');
  //       // await tester.enterText(find.byType(TextField), '123456');
  //
  //       final Finder login = find.widgetWithText(ElevatedButton, "LOGIN");
  //
  //       // Emulate a tap on the floating action button.
  //       await tester.tap(login);
  //
  //
  //       await tester.pumpAndSettle(Duration(seconds: 4));
  //       // await Future.delayed(const Duration(seconds: 10), (){});
  //
  //       final Finder drawer = find.byIcon(Icons.menu);
  //
  //       await tester.tap(drawer);
  //       // Trigger a frame.
  //       await tester.pumpAndSettle();
  //       // await Future.delayed(const Duration(seconds: 5), (){});
  //       final Finder trackexpences = find.text("Track Expenses");
  //
  //       // Emulate a tap on the floating action button.
  //       await tester.tap(trackexpences);
  //       // Trigger a frame.
  //       await tester.pumpAndSettle();
  //       await Future.delayed(const Duration(seconds: 5), (){});
  //       // await Future.delayed(const Duration(seconds: 5), (){});
  //
  //
  //
  //       final Finder delete = find.byIcon(Icons.delete);
  //       await tester.pumpAndSettle();
  //       await tester.tap(delete);
  //       await tester.pumpAndSettle();
  //
  //       await Future.delayed(const Duration(seconds: 5), (){});
  //
  //     });
  // group('welcome-to-edit_profile', () {
  //   // testWidgets('Tap on lets go button and then enter the credentials and tap on'
  //   //     ' the login button and ask for the location permission, opens the drawer '
  //   //     'and tap on the edit profile button',
  //   //         (WidgetTester tester) async {
  //   //       await Future.delayed(const Duration(seconds: 4), (){});
  //   //       app.main();
  //   //       // await Future.delayed(const Duration(seconds: 5), (){});
  //   //       await tester.pumpAndSettle();
  //   //
  //   //       // Verify the counter starts at 0.
  //   //       // expect(find.text('0'), findsOneWidget);
  //   //       expect(find.text('Enjoy Every        '), findsOneWidget);
  //   //
  //   //
  //   //       // Finds the floating action button to tap on.
  //   //       final Finder lgs_b = find.widgetWithText(ElevatedButton, "Let's Get Started");
  //   //
  //   //       // Emulate a tap on the floating action button.
  //   //       await tester.tap(lgs_b);
  //   //
  //   //       // Trigger a frame.
  //   //       await tester.pumpAndSettle();
  //   //
  //   //       // Verify the counter increments by 1.
  //   //       expect(find.text('Login '), findsOneWidget);
  //   //
  //   //       // await tester.enterText(find.text("Username or Email"), 'ali@gmail.com');
  //   //       await tester.enterText(find.byKey(Key('username')), 'ali@gmail.com');
  //   //       await tester.enterText(find.byKey(Key('password')), '123456');
  //   //       // await tester.enterText(find.byType(TextField), '123456');
  //   //
  //   //       final Finder login = find.widgetWithText(ElevatedButton, "LOGIN");
  //   //
  //   //       //
  //   //       // bool serviceEnabled;
  //   //       // LocationPermission permission;
  //   //       // // Test if location services are enabled.
  //   //       // serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   //       // if (!serviceEnabled) {
  //   //       //   // Location services are not enabled don't continue
  //   //       //   // accessing the position and request users of the
  //   //       //   // App to enable the location services.
  //   //       //   return Future.error('Location services are disabled.');
  //   //       // }
  //   //       // permission = await Geolocator.checkPermission();
  //   //       // if (permission == LocationPermission.denied) {
  //   //       //   permission = await Geolocator.requestPermission();
  //   //       //   if (permission == LocationPermission.denied) {
  //   //       //     // Permissions are denied, next time you could try
  //   //       //     // requesting permissions again (this is also where
  //   //       //     // Android's shouldShowRequestPermissionRationale
  //   //       //     // returned true. According to Android guidelines
  //   //       //     // your App should show an explanatory UI now.
  //   //       //     return Future.error('Location permissions are denied');
  //   //       //   }
  //   //       // }
  //   //       // if (permission == LocationPermission.deniedForever) {
  //   //       //   // Permissions are denied forever, handle appropriately.
  //   //       //   return Future.error(
  //   //       //       'Location permissions are permanently denied, we cannot request permissions.');
  //   //       // }
  //   //       // Emulate a tap on the floating action button.
  //   //       await tester.tap(login);
  //   //
  //   //       await Future.delayed(const Duration(seconds: 4), (){});
  //   //
  //   //
  //   //
  //   //       await tester.pumpAndSettle(Duration(seconds: 4));
  //   //       // await Future.delayed(const Duration(seconds: 10), (){});
  //   //
  //   //       final Finder drawer = find.byIcon(Icons.menu);
  //   //
  //   //       await tester.tap(drawer);
  //   //       // Trigger a frame.
  //   //       await tester.pumpAndSettle();
  //   //       // await Future.delayed(const Duration(seconds: 5), (){});
  //   //       final Finder editprofile = find.widgetWithText(TextButton, "Edit Profile");
  //   //
  //   //       // Emulate a tap on the floating action button.
  //   //       await tester.tap(editprofile);
  //   //
  //   //       // Trigger a frame.
  //   //       await tester.pumpAndSettle();
  //   //       // await Future.delayed(const Duration(seconds: 5), (){});
  //   //
  //   //
  //   //
  //   //       await tester.enterText(find.byKey(ValueKey('city')), 'Manitoba');
  //   //       await tester.pumpAndSettle();
  //   //       // await Future.delayed(const Duration(seconds: 5), (){});
  //   //       await Future.delayed(const Duration(seconds: 5), (){});
  //   //       await tester.pumpAndSettle();
  //   //       final Finder convert = find.widgetWithText(ElevatedButton, "Update Profile");
  //   //       await tester.pumpAndSettle();
  //   //       await tester.tap(convert);
  //   //       await tester.pumpAndSettle();
  //   //
  //   //       await Future.delayed(const Duration(seconds: 5), (){});
  //   //
  //   //     });
  // });
  //

}
