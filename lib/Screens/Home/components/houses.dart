import 'dart:convert';

import 'package:dumper/Screens/Details/details_screen.dart';
import 'package:dumper/constants/constants.dart';
import 'package:dumper/data/data.dart';
import 'package:dumper/main.dart';
import 'package:dumper/model/house.dart';
import 'package:dumper/model/property_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Houses extends StatefulWidget {
  const Houses({Key key}) : super(key: key);

  @override
  _HousesState createState() => _HousesState();
}

class _HousesState extends State<Houses> {
  int currentPage = 1;

  List<Content> _property = [];

  Future<bool> getData() async {
    final Uri url =
        Uri.parse("$SERVER_IP/api/auth/property/all");

    final response =
        await http.get(url, headers: {"ContentType": "application/json"});

    if (response.statusCode == 200) {
      final result = propertyModelFromJson(response.body);

      _property = result.content;

      currentPage++;

      setState(() {});

      return true;
    } else {
      return false;
    }
  }

  showImage(String image) {
    return Image.memory(base64Decode(image));
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    House house = houseList[1];
    return Expanded(
      child: FutureBuilder<Content>(
        builder: (context, snapshot) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: _property.length,
            itemBuilder: (context, index) {
              final data = _property[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailsScreen(
                        house: _property[index],
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: appPadding, vertical: appPadding / 2),
                  child: SizedBox(
                    height: 250,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                child: showImage(data.propertyImages[index].data),
                                // height: 180,
                                // width: size.width,
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
                              '\₹${data.price}',
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
                                data.description,
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
                              '${data.bedrooms} bedrooms / ',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              ' ${data.bathrooms} bathrooms / ',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              ' ${data.sqFeet} sqft  ',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
