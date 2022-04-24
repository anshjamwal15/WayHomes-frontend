import 'dart:convert';

import 'package:dumper/Screens/Details/details_screen.dart';
import 'package:dumper/Screens/Login/login_screen.dart';
import 'package:dumper/Screens/Profile/edit_profile.dart';
import 'package:dumper/constants/constants.dart';
import 'package:dumper/main.dart';
import 'package:dumper/model/profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({Key key}) : super(key: key);

  @override
  _NavigationDrawerWidget createState() => _NavigationDrawerWidget();
}

class _NavigationDrawerWidget extends State<NavigationDrawerWidget> {

  Future<Profile> profile;

  Future<Profile> fetchUserData(int userId) async {
    final Uri url = Uri.parse("$SERVER_IP/api/auth/user/get-user-info/$userId");

    final response =
        await http.get(url, headers: {"ContentType": "application/json"});

    if (response.statusCode == 200) {
      return Profile.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch user');
    }
  }
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  void initState() {
    super.initState();
    profile = fetchUserData(1);
  }

  @override
  Widget build(BuildContext context) {
    const name = 'User Six';
    const email = 'UserSix@gmail.com';
    // var urlImage = "assets/icons/login.svg";
    return Drawer(
      child: Material(
        color: sPrimaryColor,
        child: FutureBuilder<Profile>(
          future: profile,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  buildHeader(
                    urlImage: image,
                    name: snapshot.data.username,
                    email: snapshot.data.email,
                  ),
                  const Divider(color: Colors.white70),
                  Container(
                    padding: padding,
                    child: Column(
                      children: [
                        buildMenuItem(
                          text: 'Home',
                          icon: Icons.house,
                          onClicked: () => selectedItem(context, 0),
                        ),
                        const SizedBox(height: 16),
                        buildMenuItem(
                          text: 'Favourites',
                          icon: Icons.favorite_border_rounded,
                          onClicked: () => selectedItem(context, 1),
                        ),
                        const SizedBox(height: 16),
                        buildMenuItem(
                          text: 'Explore Localities',
                          icon: Icons.account_balance_sharp,
                          onClicked: () => selectedItem(context, 2),
                        ),
                        const SizedBox(height: 16),
                        buildMenuItem(
                          text: 'Updates',
                          icon: Icons.update,
                          onClicked: () => selectedItem(context, 3),
                        ),
                        const SizedBox(height: 16),
                        buildMenuItem(
                          text: 'Settings',
                          icon: Icons.settings,
                          onClicked: () => selectedItem(context, 4),
                        ),
                        const SizedBox(height: 16),
                        buildMenuItem(
                          text: 'Logout',
                          icon: Icons.logout,
                          onClicked: () async {
                            final SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            preferences.remove('email');
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Widget buildHeader({
    String urlImage,
    String name,
    String email,
    VoidCallback onClicked,
  }) =>
      InkWell(
        child: Container(
          padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(image),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const EditProfilePage()),
                  );
                },
                child: const CircleAvatar(
                  radius: 20,
                  backgroundColor: kPrimaryColor,
                  child: Icon(Icons.edit, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    String text,
    IconData icon,
    VoidCallback onClicked,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const DetailsScreen(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const DetailsScreen(),
        ));
        break;
    }
  }
}
