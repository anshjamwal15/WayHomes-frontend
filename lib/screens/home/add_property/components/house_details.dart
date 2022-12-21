import 'dart:io';

import 'package:dumper/constants/constants.dart';
import 'package:dumper/screens/home/landing_page.dart';
import 'package:dumper/services/property_service.dart';
import 'package:flutter/material.dart';

class HouseDetails extends StatefulWidget {
  HouseDetails({Key key, this.imgList, this.showLoading}) : super(key: key);
  List<String> imgList;
  Function(bool) showLoading;
  @override
  _HouseDetailsState createState() => _HouseDetailsState();
}

class _HouseDetailsState extends State<HouseDetails> {
  final sqFeetController = TextEditingController();
  final bedroomsController = TextEditingController();
  final bathroomsController = TextEditingController();
  final garagesController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final addressController = TextEditingController();
  final tagsController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Connectivity.onConnectivityChanged.cancel();
    sqFeetController.dispose();
    bedroomsController.dispose();
    bathroomsController.dispose();
    garagesController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    addressController.dispose();
    tagsController.dispose();
    super.dispose();
  }
  void goBack() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const LandingPage(),
    ));
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final bool showBottomBtn = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: sqFeetController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter sqFeet',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: bedroomsController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter bedrooms',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: bathroomsController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter bathrooms',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: garagesController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter garages',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: priceController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Enter price',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                child: TextFormField(
                  controller: tagsController,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: '#tags',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                child: TextFormField(
                  controller: addressController,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Add address',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                child: TextFormField(
                  controller: descriptionController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter description',
                  ),
                ),
              ),
              // Buttons Widget Started
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(bottom: appPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: size.width * 0.34,
                        height: 50,
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                  color: darkBlue.withOpacity(0.6),
                                  offset: const Offset(0, 10),
                                  blurRadius: 10)
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'CANCEL',
                              style: TextStyle(
                                color: white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Map<String, String> propertyData = {
                          'sqFeet': sqFeetController.text,
                          'bedrooms': bedroomsController.text,
                          'bathrooms': bathroomsController.text,
                          'garages': garagesController.text,
                          'price': priceController.text,
                          'description': descriptionController.text,
                          'address': addressController.text,
                          'tags': tagsController.text
                        };
                        widget.showLoading(true);
                        PropertyService()
                            .uploadProperty(
                          propertyData,
                          widget.imgList,
                        )
                            .then((value) {
                          if (value == "success") {
                            // TODO Solve this error :- Consider canceling any active work during "dispose" or using the "mounted" getter to determine if the State is still active.
                            widget.showLoading(false);
                            // goBack();
                          } else {
                            widget.showLoading(false);
                          }
                        });
                      },
                      child: Container(
                        width: size.width * 0.34,
                        height: 50,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: darkBlue.withOpacity(0.6),
                                offset: const Offset(0, 10),
                                blurRadius: 10)
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'SAVE',
                              style: TextStyle(
                                color: white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
