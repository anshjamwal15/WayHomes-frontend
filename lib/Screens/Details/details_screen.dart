import 'package:dumper/Screens/Details/components/bottom_buttons.dart';
import 'package:dumper/Screens/Details/components/carousel_images.dart';
import 'package:dumper/Screens/Details/components/custom_app_bar.dart';
import 'package:dumper/Screens/Details/components/house_details.dart';
import 'package:dumper/model/property_model.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final Content house;

  const DetailsScreen({Key key, this.house}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Stack(
                children: [
                  CarouselImages(house: widget.house),
                  CustomAppBar(isFav: widget.house.isFav),
                ],
              ),
              HouseDetails(
                houses: widget.house,
              ),
            ],
          ),
          BottomButtons(house: widget.house),
        ],
      ),
    );
  }
}
