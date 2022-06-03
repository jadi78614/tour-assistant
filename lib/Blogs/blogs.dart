import 'package:testing_app/Blogs/Blog/addBlog.dart';
import 'package:testing_app/Blogs/Pages/HomePage.dart';
import 'package:testing_app/Blogs/Profile/MainProfile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Pages/LoadingPage.dart';
import 'Pages/WelcomePage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BlogsWidget extends StatefulWidget {
  @override
  _BlogsWidgetState createState() => _BlogsWidgetState();
}

class _BlogsWidgetState extends State<BlogsWidget> {
  Widget page = LoadingPage();
  final storage = FlutterSecureStorage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    String? token = await storage.read(key: "token");
    if (token != null) {
      setState(() {
        page = HomePage();
      });
    } else {
      setState(() {
        page = WelcomePage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:page,
    );
  }
}
