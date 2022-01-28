import 'dart:convert';

import 'package:dumper/Screens/Details/details_screen.dart';
import 'package:dumper/Screens/Home/landing_page.dart';
import 'package:dumper/constants/constants.dart';
import 'package:dumper/data/data.dart';
import 'package:dumper/model/house.dart';
import 'package:dumper/model/property_model.dart';
import 'package:dumper/services/service_api.dart';
import 'package:flutter/material.dart';

class Houses extends StatefulWidget {
  const Houses({Key key}) : super(key: key);

  @override
  _HousesState createState() => _HousesState();
}

class _HousesState extends State<Houses> {
  Future<PropertyModel> _propertyModel;

  @override
  void initState() {
    super.initState();
    _propertyModel = PropertyService().getProperty();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    House house = houseList[1];
    return Expanded(
      child: FutureBuilder<PropertyModel>(
        future: _propertyModel,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data.content.length,
              itemBuilder: (context, index) {
                // var image = snapshot.data.content[0].propertyImages[0].path;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LandingPage(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: appPadding, vertical: appPadding / 2),
                    child: Container(
                      height: 250,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image(
                                  height: 180,
                                  width: size.width,
                                  fit: BoxFit.cover,
                                  image: const NetworkImage(
                                      "https://www.commercialproperty.review/wp-content/uploads/2020/08/ATS-Greens-Village-Aparments-Sector-93-Noida.jpg"),
                                ),
                              ),
                              Positioned(
                                right: appPadding / 2,
                                top: appPadding / 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: IconButton(
                                    icon: house.isFav
                                        ? const Icon(
                                            Icons.favorite_rounded,
                                            color: kPrimaryColor,
                                          )
                                        : const Icon(
                                            Icons.favorite_border_rounded,
                                            color: kPrimaryColor,
                                          ),
                                    onPressed: () {
                                      setState(() {
                                        house.isFav = !house.isFav;
                                      });
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '\₹${snapshot.data.content[0].price.toStringAsFixed(4)}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  snapshot.data.content[1].description,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: black.withOpacity(0.4)),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '${snapshot.data.content[0].bedrooms} bedrooms / ',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                ' ${snapshot.data.content[0].bathrooms} bathrooms / ',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                ' ${snapshot.data.content[0].sqFeet} sqft  ',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
