import 'dart:async';

import 'package:dumper/Screens/Home/components/body.dart';
import 'package:dumper/components/loading_circle.dart';
import 'package:dumper/screens/Login/login_screen.dart';
import 'package:dumper/services/helper_functions.dart';
import 'package:dumper/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key key, this.loginType}) : super(key: key);
  final String loginType;
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool _loading = true;
  User user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    if (user != null) {
      HelperFunctions.saveUserEmailSharedPreference(user.email);
      HelperFunctions.saveUserNameSharedPreference(user.displayName);
      if (widget.loginType != null && widget.loginType == "google") {
        UserService().signUp(
            user.displayName, user.email, "no-password", widget.loginType);
      }
      if (widget.loginType != null && widget.loginType == "twitter") {
        UserService().signUp(
            user.displayName, user.email, "no-password", widget.loginType);
      }
      if (widget.loginType != null && widget.loginType == "facebook") {
        UserService().signUp(
            user.displayName, user.email, "no-password", widget.loginType);
      }
    }
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _loading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? const LoadingCircle(size: 800)
          : Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Body(),
              ],
            ),
    );
  }
}
