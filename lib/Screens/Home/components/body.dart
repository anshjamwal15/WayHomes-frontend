import 'package:dumper/Screens/Home/components/bottom_buttons.dart';
import 'package:dumper/Screens/Home/components/categories.dart';
import 'package:dumper/Screens/Home/components/custom_app_bar.dart';
import 'package:dumper/Screens/Home/components/houses.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: const [
              CustomAppBar(),
              Categories(),
              Houses(),
            ],
          ),
          const BottomButtons(),
        ],
      ),
    );
  }
}
