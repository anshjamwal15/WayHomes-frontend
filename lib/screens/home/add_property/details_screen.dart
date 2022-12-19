import 'package:dumper/screens/Home/add_property/components/bottom_buttons.dart';
import 'package:dumper/screens/Home/add_property/components/carousel_images.dart';
import 'package:dumper/screens/Home/add_property/components/custom_app_bar.dart';
import 'package:dumper/screens/home/add_property/components/house_details.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key key}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();

  // ignore: library_private_types_in_public_api
  static _DetailsScreenState of(BuildContext context) =>
      context.findAncestorStateOfType<_DetailsScreenState>();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final bool showBottomBtn = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Stack(
                children: const [
                  CarouselImages(),
                  CustomAppBar(),
                ],
              ),
              const HouseDetails(),
            ],
          ),
          showBottomBtn ? const BottomButtons() : const Opacity(opacity: 0.1),
        ],
      ),
    );
  }
}
