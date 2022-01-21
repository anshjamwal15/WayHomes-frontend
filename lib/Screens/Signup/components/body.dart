import 'dart:convert';

import 'package:dumper/Screens/Login/login_screen.dart';
import 'package:dumper/Screens/Signup/components/social_icon.dart';
import 'package:dumper/Screens/Welcome/components/Background.dart';
import 'package:dumper/components/text_field_container.dart';
import 'package:dumper/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import '../../../main.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

Future<String> createUser(
    String username, String email, String password) async {
  final response = await http.post(
    Uri.parse('$SERVER_IP/api/auth/signup'),
    body: jsonEncode(<String, String>{
      'username': username,
      'email': email,
      'password': password,
    }),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) return response.body;
  return null;
}

class _BodyState extends State<Body> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isHidden = true;
  bool login = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: TextFieldContainer(
                child: TextField(
                  controller: usernameController,
                  cursorColor: kPrimaryColor,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.person,
                      color: kPrimaryColor,
                    ),
                    hintText: "Username",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
              child: TextFieldContainer(
                child: TextField(
                  controller: emailController,
                  cursorColor: kPrimaryColor,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      color: kPrimaryColor,
                    ),
                    hintText: "Your Email",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
              child: TextFieldContainer(
                child: TextField(
                  controller: passwordController,
                  obscureText: _isHidden,
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: kPrimaryColor,
                    ),
                    hintText: "Password",
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _isHidden = !_isHidden;
                        });
                      },
                      child: Icon(
                        _isHidden ? Icons.visibility : Icons.visibility_off,
                        color: kPrimaryColor,
                      ),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              width: size.width * 0.6,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: ElevatedButton(
                  child: const Text(
                    "SIGN UP",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    var username = usernameController.text;
                    var email = emailController.text;
                    var password = passwordController.text;
                    var jwt = await createUser(username, email, password);
                    if (jwt != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  login
                      ? "Already have and Account ? "
                      : "Don't have an Account ? ",
                  style: const TextStyle(color: kPrimaryColor),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const LoginScreen();
                        },
                      ),
                    );
                  },
                  child: Text(
                    login ? "Sign Up" : "Sign In",
                    style: const TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: size.height * 0.03),
            Row(
              children: const <Widget>[
                Expanded(
                  child: Divider(
                    color: Color(0xFFD9D9D9),
                    height: 1.5,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "OR",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Color(0xFFD9D9D9),
                    height: 1.5,
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocialIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocialIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocialIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
