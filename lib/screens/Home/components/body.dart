import 'package:badges/badges.dart';
import 'package:dumper/Screens/Home/components/bottom_buttons.dart';
import 'package:dumper/Screens/Home/components/houses.dart';
import 'package:dumper/Screens/seller_messages/chats_screen.dart';
import 'package:dumper/components/navigation_drawer_widget.dart';
import 'package:dumper/model/category_model.dart';
import 'package:dumper/services/helper_functions.dart';
import 'package:dumper/services/property_service.dart';
import 'package:flutter/material.dart';
import 'package:dumper/constants/roles_list.dart';
import '../../../constants/constants.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  int incomingMessages = 1;
  String username = '';
  String email = '';
  List<CategoryModel> categoriesList;

  @override
  void initState() {
    HelperFunctions.getUserNameSharedPreference().then((value) => {
          setState(() {
            username = value;
          })
        });
    HelperFunctions.getUserEmailSharedPreference().then((value) => {
          setState(() {
            email = value;
          })
        });
    PropertyService().getCategories().then((value) {
      setState(() {
        categoriesList = value;
      });
    });
    super.initState();
  }

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
                                border: Border.all(
                                    color: kPrimaryColor.withOpacity(0.4)),
                                borderRadius: BorderRadius.circular(15)),
                            child: IconButton(
                              icon: const Icon(Icons.sort_rounded),
                              color: kPrimaryColor,
                              onPressed: () {
                                _scaffoldkey.currentState.openDrawer();
                              },
                            ),
                          ),
                          Role.getString() == Role.modRole
                              ? Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: kPrimaryColor.withOpacity(0.4)),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Badge(
                                    padding: const EdgeInsets.all(8),
                                    badgeContent: Text(
                                      '$incomingMessages',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: white,
                                      ),
                                    ),
                                    badgeColor: kPrimaryColor,
                                    child: IconButton(
                                      icon: const Icon(
                                        (Icons.mail_rounded),
                                        color: kPrimaryColor,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                ChatsScreen(username: username),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                )
                              : const Opacity(opacity: 0.64),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'City',
                            style: TextStyle(
                                color: kPrimaryColor.withOpacity(0.4),
                                fontSize: 18),
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
              categoriesList != null
                  ? Expanded(
                      child: Houses(categoriesList: categoriesList),
                    )
                  : const CircularProgressIndicator(),
            ],
          ),
          const BottomButtons(),
        ],
      ),
      drawer: NavigationDrawerWidget(username: username, email: email),
    );
  }
}
