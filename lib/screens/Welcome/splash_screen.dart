import 'dart:async';

import 'package:dumper/Screens/Home/landing_page.dart';
import 'package:dumper/Screens/Login/login_screen.dart';
import 'package:dumper/Screens/Welcome/components/Background.dart';
import 'package:dumper/services/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String username;

  @override
  void initState() {
    getValidation().whenComplete(() async {
      Timer(
        const Duration(seconds: 2),
        () => username == null
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              )
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LandingPage(),
                ),
              ),
      );
    });
    super.initState();
  }

  Future getValidation() async {
    String name = await HelperFunctions.getUserNameSharedPreference();
    setState(() {
      username = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Welcome To Dumper",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/chat.svg",
                height: size.height * 0.45,
              ),
              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
