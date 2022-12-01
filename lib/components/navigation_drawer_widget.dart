import 'package:dumper/Screens/Details/details_screen.dart';
import 'package:dumper/Screens/Login/login_screen.dart';
import 'package:dumper/services/login_service.dart';
import 'package:dumper/Screens/Profile/edit_profile.dart';
import 'package:dumper/constants/constants.dart';
import 'package:dumper/data/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class NavigationDrawerWidget extends StatefulWidget {
  NavigationDrawerWidget({Key key, this.username, this.email})
      : super(key: key);
  String username;
  String email;
  @override
  _NavigationDrawerWidget createState() => _NavigationDrawerWidget();
}

class _NavigationDrawerWidget extends State<NavigationDrawerWidget> {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: sPrimaryColor,
        child: ListView(
          children: [
            buildHeader(
              name: widget.username,
              email: widget.email,
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
                    onClicked: () {
                      LoginService().authSignOut();
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
        ),
      ),
    );
  }

  Widget buildHeader({
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
                backgroundImage: NetworkImage(myUrlAvatar),
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
                      builder: (context) => const EditProfilePage(),
                    ),
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
