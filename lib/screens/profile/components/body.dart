import 'package:dumper/Screens/Home/landing_page.dart';
import 'package:dumper/components/global_app_bar.dart';
import 'package:dumper/constants/constants.dart';
import 'package:dumper/data/dummy_data.dart';
import 'package:dumper/model/profile_model.dart';
import 'package:dumper/services/helper_functions.dart';
import 'package:dumper/services/user_service.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future<Profile> profile;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool showPassword = true;

  @override
  void initState() {
    profile = UserService().fetchUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GlobalAppBar(),
      body: Container(
        padding: const EdgeInsets.only(
          left: appPadding,
          top: appPadding + 10,
          right: appPadding,
        ),
        child: GestureDetector(
          onTap: () {},
          child: FutureBuilder<Profile>(
            future: profile,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: [
                    const Text(
                      "Edit Profile",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                  ),
                                ],
                                shape: BoxShape.circle,
                                image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(myUrlAvatar),
                                )),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 4,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                color: kPrimaryColor,
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    buildTextField("Username", snapshot.data.username, false,
                        usernameController),
                    buildTextField(
                        "E-mail", snapshot.data.email, false, emailController),
                    buildTextField(
                        "Password", "Password", true, passwordController),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: const Text(
                            "CANCEL",
                            style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            var email = emailController.text;
                            var username = usernameController.text;
                            var password = passwordController.text;
                            Map<String, String> data = {
                              "email": email,
                              "username": username,
                              "password": password
                            };
                            await UserService().updateUserProfile(data);
                            if (email.isNotEmpty) {
                              await HelperFunctions
                                  .saveUserEmailSharedPreference(email);
                            }
                            if (username.isNotEmpty) {
                              await HelperFunctions
                                  .saveUserNameSharedPreference(username);
                            }
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => LandingPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kPrimaryColor,
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            "SAVE",
                            style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeHolder,
      bool isPasswordTextField, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: controller,
        cursorColor: kPrimaryColor,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
            color: kPrimaryLightColor,
          )),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
            color: kPrimaryColor,
          )),
          suffixIcon: isPasswordTextField
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                    color: kPrimaryColor,
                  ),
                )
              : null,
          contentPadding: const EdgeInsets.only(bottom: 3),
          labelText: labelText,
          labelStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeHolder,
          hintStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: Colors.grey,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
