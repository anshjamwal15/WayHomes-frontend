import 'package:dumper/Screens/Home/components/bottom_buttons.dart';
import 'package:dumper/Screens/Home/components/categories.dart';
import 'package:dumper/Screens/Home/components/houses.dart';
import 'package:dumper/components/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldkey,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
            Padding(
              padding: const EdgeInsets.only(
                left: appPadding,
                right: appPadding,
                top: appPadding * 2,
              ),
              child: SizedBox(
                height: size.height * 0.22,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              border: Border.all(color: kPrimaryColor.withOpacity(0.4)),
                              borderRadius: BorderRadius.circular(15)),
                          child: IconButton(
                            icon: const Icon(Icons.sort_rounded),
                            color: kPrimaryColor, onPressed: () { _scaffoldkey.currentState.openDrawer(); },
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: kPrimaryColor.withOpacity(0.4)),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            (Icons.insights_rounded),
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'City',
                          style: TextStyle(
                              color: kPrimaryColor.withOpacity(0.4), fontSize: 18),
                        ),
                        SizedBox(height: size.height * 0.01),
                        const Text(
                          'Noida',
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ),
              const Categories(),
              const Houses(),
            ],
          ),
          const BottomButtons(),
        ],
      ),
      drawer: const NavigationDrawerWidget(),
    );
  }
}
