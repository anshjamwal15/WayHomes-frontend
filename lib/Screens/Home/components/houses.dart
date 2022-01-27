import 'dart:convert';

import 'package:dumper/Screens/Details/details_screen.dart';
import 'package:dumper/Screens/Home/landing_page.dart';
import 'package:dumper/constants/constants.dart';
import 'package:dumper/data/data.dart';
import 'package:dumper/model/house.dart';
import 'package:dumper/model/property_model.dart';
import 'package:dumper/services/api_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    _propertyModel = API_Manager().getProperties();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    House house = houseList[1];
    return Expanded(
      child: FutureBuilder<PropertyModel>(
        future: _propertyModel,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data.propertyImages.length,
              itemBuilder: (context, index) {
                var image = snapshot.data.propertyImages[index];
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
                                child: Image.network(
                                  // height: 180,
                                  // width: size.width,
                                  // fit: BoxFit.cover,
                                  // image: image.path,
                                  image.path
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
                                '\₹${snapshot.data.price.toStringAsFixed(4)}',
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
                                  snapshot.data.description,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 15, color: black.withOpacity(0.4)),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '${snapshot.data.bedrooms} bedrooms / ',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                ' ${snapshot.data.bathrooms} bathrooms / ',
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                ' ${snapshot.data.sqFeet} sqft  ',
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
