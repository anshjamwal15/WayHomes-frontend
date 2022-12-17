import 'package:dumper/constants/constants.dart';
import 'package:dumper/model/property_model.dart';
import 'package:flutter/material.dart';

class HouseDetails extends StatefulWidget {
  const HouseDetails({Key key}) : super(key: key);

  @override
  _HouseDetailsState createState() => _HouseDetailsState();
}

class _HouseDetailsState extends State<HouseDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<Content>(
        builder: (context, snapshot) {
          return ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: appPadding,
                  left: appPadding,
                  right: appPadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: const TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter a search term',
                            ),
                          ),
                        ),
                        // Text(
                        //   // '\₹${widget.houses.price.toString()}',
                        //   '5000',
                        //   style: TextStyle(
                        //     fontSize: 28,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                      ],
                    ),
                    // TextFormField(
                    //   decoration: const InputDecoration(
                    //     border: UnderlineInputBorder(),
                    //     labelText: 'Enter your username',
                    //   ),
                    // ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: appPadding,
                  bottom: appPadding,
                ),
                child: Text(
                  'House information',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 130,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: appPadding,
                        bottom: appPadding,
                      ),
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: black.withOpacity(0.4),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "widget.houses.sqFeet.toString()",
                              style: TextStyle(
                                color: black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Square foot',
                              style: TextStyle(
                                color: black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: appPadding,
                        bottom: appPadding,
                      ),
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: black.withOpacity(0.4),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'widget.houses.bedrooms.toString()',
                              style: TextStyle(
                                color: black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Bedrooms',
                              style: TextStyle(
                                color: black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: appPadding,
                        bottom: appPadding,
                      ),
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: black.withOpacity(0.4),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'widget.houses.bathrooms.toString()',
                              style: const TextStyle(
                                color: black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Bathrooms',
                              style: TextStyle(
                                color: black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: appPadding,
                        bottom: appPadding,
                      ),
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: black.withOpacity(0.4),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'widget.houses.garages.toString()',
                              style: TextStyle(
                                color: black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Garages',
                              style: TextStyle(
                                color: black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: appPadding,
                  right: appPadding,
                  bottom: appPadding * 4,
                ),
                child: Text(
                  'widget.houses.description',
                  style: TextStyle(
                    color: black.withOpacity(0.4),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
