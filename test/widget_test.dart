// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_app/Dashboard/TouristDashboard/user_chat.dart';
import 'package:testing_app/EditProfile/editprofile.dart';
import 'package:testing_app/Forgotpassword/enterotpscreen.dart';
import 'package:testing_app/Forgotpassword/forgotpassword.dart';
import 'package:testing_app/Login/login_screen.dart';
import 'package:testing_app/Signup/signup_screen.dart';
import 'package:testing_app/Signup/singupemailverification.dart';
import 'package:testing_app/Weather/screens/city_screen.dart';
import 'package:testing_app/Weather/screens/loading_screen.dart';
import 'package:testing_app/currencyconverter/home.dart';
import 'package:testing_app/main.dart';
import 'package:integration_test/integration_test.dart';

import 'package:testing_app/main.dart' as app;

// Widget createLoginScreen() => LoginScreen();

Widget welcomescreen = MediaQuery(
    data: MediaQueryData(),
    child: MaterialApp(
        home: Scaffold(
      body: WelcomeScreen(),
    )));

Widget loginscreen = MediaQuery(
    data: MediaQueryData(),
    child: MaterialApp(
        home: Scaffold(
      body: LoginScreen(),
    )));

Widget forgotpwdscreen = MediaQuery(
    data: MediaQueryData(),
    child: MaterialApp(
        home: Scaffold(
      body: ForgotPasswordScreen(),
    )));

Widget otpscreen = MediaQuery(
    data: MediaQueryData(),
    child: MaterialApp(
        home: Scaffold(
      body: OtpEnterScreen(
        email: "ali@gmail.com",
        code: 1010,
      ),
    )));

Widget editprofilescreen = MediaQuery(
    data: MediaQueryData(),
    child: MaterialApp(
        home: Scaffold(
      body: EditProfileScreen(
        address: 'abc',
        status: 'tourist',
        id: '123',
        city: 'manitoba',
        name: 'Danish',
        password: '123456',
      ),
    )));

Widget signup = MediaQuery(
    data: MediaQueryData(),
    child: MaterialApp(
        home: Scaffold(
      body: SignUpScreen(
        email: "ali@gmail.com",
      ),
    )));

Widget signupverification = MediaQuery(
    data: MediaQueryData(),
    child: MaterialApp(
        home: Scaffold(
      body: SignUpVerification(),
    )));

Widget chatapp = MediaQuery(
    data: MediaQueryData(),
    child: MaterialApp(
        home: Scaffold(
      body: ChatTourist(
        stringid: '61aa42cb867114c0b5b4631a',
      ),
    )));

Widget Currencyconverter = MediaQuery(
    data: MediaQueryData(),
    child: MaterialApp(
        home: Scaffold(
          body: CurrencyConverterScreen(),
        )));

Widget manageexpense = MediaQuery(
    data: MediaQueryData(),
    child: MaterialApp(
        home: Scaffold(
          body: CurrencyConverterScreen(),
        )));



Future<void> main() async {

  group(("Welcome Screen tests"),(){
    testWidgets('Test Welcome Screen button', (WidgetTester tester) async {

      const childWidget = Padding(padding: EdgeInsets.zero);
      // Provide the childWidget to the Container.
      await tester.pumpWidget(Container(child: childWidget));

      await tester.pumpWidget(welcomescreen);
      expect(find.text('Let\'s Get Started'), findsOneWidget);
    });

    testWidgets('Test Welcome Screen Text 1', (WidgetTester tester) async{
      await tester.pumpWidget(welcomescreen);
      expect(find.text('Enjoy Every        '), findsOneWidget);
    });

    testWidgets('Test Welcome Screen Text 2', (WidgetTester tester) async {
      await tester.pumpWidget(welcomescreen);
      expect(find.text('Moment With Us '), findsOneWidget);
    });
  });


  group(("Login Screen tests"),(){
    testWidgets('Login Screen Testing login Text', (WidgetTester tester) async {
      await tester.pumpWidget(loginscreen);
      expect(find.text('Login '), findsOneWidget);
    });

    testWidgets('Login Screen Testing login Email TextField', (WidgetTester tester) async{
      await tester.pumpWidget(loginscreen);
      expect(find.byKey(Key('username')), findsOneWidget);
    });

    testWidgets('Login Screen Testing Password TextField', (WidgetTester tester) async {
      await tester.pumpWidget(loginscreen);
      expect(find.byKey(Key('password')), findsOneWidget);
    });

    testWidgets('Login Screen Testing Forgot Password', (WidgetTester tester) async {
      await tester.pumpWidget(loginscreen);
      expect(find.text('Forgot password ?'), findsOneWidget);
    });
  });

  group(("SignUp Verification Screen tests"),(){

    testWidgets('Signup Screen Testing Signup Text', (WidgetTester tester) async {
      await tester.pumpWidget(signupverification);
      expect(find.text('Signup '), findsOneWidget);
    });

    testWidgets('Signup Screen Testing Singup textfield', (WidgetTester tester) async{
      await tester.pumpWidget(signupverification);
      expect(find.byKey(Key('Email')), findsOneWidget);
    });

    testWidgets('Signup Screen Testing Enter OTP textfield', (WidgetTester tester) async{
      await tester.pumpWidget(signupverification);
      expect(find.byKey(ValueKey("otp"),), findsOneWidget);
    });

    testWidgets('Signup Screen Testing Send OTP Button', (WidgetTester tester) async{
      await tester.pumpWidget(signupverification);
      final Finder textbuttun =
      find.widgetWithText(TextButton, "Send OTP");
      await tester.tap(textbuttun);
      await tester.pump();
      // expect(find.text('Moment With Us '), findsOneWidget);
    });


    testWidgets('Signup Screen Testing Enter OTP Button', (WidgetTester tester) async{
      await tester.pumpWidget(signupverification);
      final Finder elevatedbuttun =
      find.widgetWithText(ElevatedButton, "Enter Otp");
      await tester.tap(elevatedbuttun);
      await tester.pump();
      // expect(find.text('Moment With Us '), findsOneWidget);
    });

  });


  group(("Forgot Password Screen tests"),(){

    testWidgets('Forgot Password screen text', (WidgetTester tester) async {
      await tester.pumpWidget(forgotpwdscreen);
      expect(find.text('Reset Password'), findsOneWidget);
    });

    testWidgets('Forgot Password screen OTP field test', (WidgetTester tester) async{
      await tester.pumpWidget(forgotpwdscreen);
      expect(find.byKey(Key('email')), findsOneWidget);
    });


    testWidgets('Forgot Password screen Button test', (WidgetTester tester) async{
      await tester.pumpWidget(forgotpwdscreen);
      final Finder elevatedbuttun =
            find.widgetWithText(ElevatedButton, "Send OTP");
        await tester.tap(elevatedbuttun);
        await tester.pump();
        // expect(find.text('Moment With Us '), findsOneWidget);
    });
  });

  group(("Edit Profile Screen"),(){

    testWidgets('Edit Profile Screen text', (WidgetTester tester) async {
      await tester.pumpWidget(editprofilescreen);
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('Edit Profile text name Field', (WidgetTester tester) async{
      await tester.pumpWidget(editprofilescreen);
      expect(find.byKey(Key('name')), findsOneWidget);
    });

    testWidgets('Edit Profile text address Field', (WidgetTester tester) async{
      await tester.pumpWidget(editprofilescreen);
      expect(find.byKey(Key('address')), findsOneWidget);
    });

    testWidgets('Edit Profile password Field', (WidgetTester tester) async{
      await tester.pumpWidget(editprofilescreen);
      expect(find.byKey(Key('password')), findsOneWidget);
    });


    testWidgets('Edit Profile screen Button test', (WidgetTester tester) async{
      await tester.pumpWidget(editprofilescreen);
      final Finder elevatedbuttun =
      find.widgetWithText(ElevatedButton, "Update Profile");
      await tester.tap(elevatedbuttun);
      await tester.pump();
      // expect(find.text('Moment With Us '), findsOneWidget);
    });
  });








  //
  // test('Test Login Screen', () {
  //   final loginscreen = MediaQueryWidgetStateLogin();
  //   expect(loginscreen.email, "");
  //   loginscreen.email = "Ali@gmail.com";
  //   expect(loginscreen.email, "Ali@gmail.com");
  // });
  //
  // test('Test Welcome Screen', () {
  //   expect(find.text('Let\'s Get Started'), findsOneWidget);
  // });
  //
  // test('Test Welcome Screen', () {
  //   final loginscreen = MediaQueryWidgetStateLogin();
  //   expect(loginscreen.email, "");
  //   loginscreen.email = "Ali@gmail.com";
  //   expect(loginscreen.email, "Ali@gmail.com");
  // });
  //
  // testWidgets('Test Login Screen', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(welcomescreen);
  //   expect(find.text('Login'), findsNothing);
  //   expect(find.text('Enjoy Every        '), findsOneWidget);
  //   expect(find.text('Moment With Us '), findsOneWidget);
  //   // await tester.pump();
  //   final Finder elevatedbuttun =
  //       find.widgetWithText(ElevatedButton, "Let's Get Started");
  //   await tester.tap(elevatedbuttun);
  //   await tester.pump();
  //   expect(find.text('Moment With Us '), findsOneWidget);
  // });
  //
  // testWidgets('Testing Chat Screen',
  //     (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(chatapp);
  //   await tester.pumpAndSettle(Duration(seconds: 5));
  //   // expect(find.text('Let\'s Get Started'), findsNothing);
  //   // expect(find.text('Enjoy Every        '), findsNothing);
  //
  //   expect(find.text('Chats'), findsOneWidget);
  //   // await tester.pump();
  //   final Finder elevatedbuttun =
  //       find.text("Muneeb");
  //   await tester.tap(elevatedbuttun);
  //   await tester.pump();
  //   expect(find.text('Moment With Us '), findsNothing);
  // });
  //
  // testWidgets('Testing WelcomeScreen Having buttons and Texts',
  //     (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(welcomescreen);
  //   expect(find.text('Let\'s Get Started'), findsOneWidget);
  //   expect(find.text('Enjoy Every        '), findsOneWidget);
  //   expect(find.text('Moment With Us '), findsOneWidget);
  //   // await tester.pump();
  //   final Finder elevatedbuttun =
  //       find.widgetWithText(ElevatedButton, "Let's Get Started");
  //   await tester.tap(elevatedbuttun);
  //   await tester.pump();
  //   expect(find.text('Moment With Us '), findsOneWidget);
  // });
  //
  // testWidgets('Testing WelcomeScreen Having buttons and Texts',
  //     (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(welcomescreen);
  //   expect(find.text('Let\'s Get Started'), findsOneWidget);
  //   expect(find.text('Enjoy Every        '), findsOneWidget);
  //   expect(find.text('Moment With Us '), findsOneWidget);
  //   // await tester.pump();
  //   final Finder elevatedbuttun =
  //       find.widgetWithText(ElevatedButton, "Let's Get Started");
  //   await tester.tap(elevatedbuttun);
  //   await tester.pump();
  //   expect(find.text('Moment With Us '), findsOneWidget);
  // });
  //
  // testWidgets('Testing WelcomeScreen Having buttons and Texts',
  //     (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(welcomescreen);
  //   expect(find.text('Let\'s Get Started'), findsOneWidget);
  //   expect(find.text('Enjoy Every        '), findsOneWidget);
  //   expect(find.text('Moment With Us '), findsOneWidget);
  //   // await tester.pump();
  //   final Finder elevatedbuttun =
  //       find.widgetWithText(ElevatedButton, "Let's Get Started");
  //   await tester.tap(elevatedbuttun);
  //   await tester.pump();
  //   expect(find.text('Moment With Us '), findsOneWidget);
  // });
  //
  // testWidgets('Testing WelcomeScreen Having buttons and Texts',
  //     (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(welcomescreen);
  //   expect(find.text('Let\'s Get Started'), findsOneWidget);
  //   expect(find.text('Enjoy Every        '), findsOneWidget);
  //   expect(find.text('Moment With Us '), findsOneWidget);
  //   // await tester.pump();
  //   final Finder elevatedbuttun =
  //       find.widgetWithText(ElevatedButton, "Let's Get Started");
  //   await tester.tap(elevatedbuttun);
  //   await tester.pump();
  //   expect(find.text('Moment With Us '), findsOneWidget);
  // });
  //
  // testWidgets('Testing WelcomeScreen Having buttons and Texts',
  //     (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(welcomescreen);
  //   expect(find.text('Let\'s Get Started'), findsOneWidget);
  //   expect(find.text('Enjoy Every        '), findsOneWidget);
  //   expect(find.text('Moment With Us '), findsOneWidget);
  //   // await tester.pump();
  //   final Finder elevatedbuttun =
  //       find.widgetWithText(ElevatedButton, "Let's Get Started");
  //   await tester.tap(elevatedbuttun);
  //   await tester.pump();
  //   expect(find.text('Moment With Us '), findsOneWidget);
  // });

  // testWidgets('Testing LoginScreen Having buttons and Texts', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //
  //   await tester.pumpWidget(loginScreen);
  //   expect(find.text('Let\'s Get Started'), findsNothing);
  //   // Expect to find the item on screen.
  //   await tester.enterText(find.byType(TextField), 'ali@gmail.com');
  //   //print("New widget is now placed");
  //   // await tester.pump();
  // });

  // testWidgets('Testing Weather Screen', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(searchcity);
  //   expect(find.text('Search by Place'), findsOneWidget);
  //   // expect(find.text('Enjoy Every        '), findsOneWidget);
  //   // expect(find.text('Moment With Us '), findsOneWidget);
  //   // await tester.pump();
  //   // final Finder elevatedbuttun = find.widgetWithText(ElevatedButton, "Let's Get Started");
  //   // await tester.tap(elevatedbuttun);
  //   await tester.pump();
  //   expect(find.text('Moment With Us '), findsNothing);
  //
  //
  // });
  // await Future.delayed(const Duration(seconds: 4), (){});
  // IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  //
  // group('end-to-end test', () {
  //   testWidgets('Tap on the screen and verify second screen opens',
  //           (WidgetTester tester) async {
  //         app.main();
  //         await tester.pumpAndSettle();
  //
  //         // Verify the counter starts at 0.
  //         // expect(find.text('0'), findsOneWidget);
  //         expect(find.text('Enjoy Every        '), findsOneWidget);
  //
  //
  //         // // Finds the floating action button to tap on.
  //         // final Finder fab = find.widgetWithText(ElevatedButton, "Let's Get Started");
  //         //
  //         // // Emulate a tap on the floating action button.
  //         // await tester.tap(fab);
  //         //
  //         // // Trigger a frame.
  //         // await tester.pumpAndSettle();
  //
  //         // Verify the counter increments by 1.
  //         // expect(find.text('Enjoy Every        '), findsNothing);
  //
  //         await tester.enterText(find.byType(TextField), 'ali@gmail.com');
  //
  //
  //       });
  // });
}
