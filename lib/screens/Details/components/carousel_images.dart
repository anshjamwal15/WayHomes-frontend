import 'dart:convert';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:dumper/constants/constants.dart';
import 'package:dumper/model/property_model.dart';
import 'package:flutter/material.dart';

class CarouselImages extends StatefulWidget {
  const CarouselImages({Key key, this.house}) : super(key: key);

  final Content house;

  @override
  _CarouselImagesState createState() => _CarouselImagesState();
}

class _CarouselImagesState extends State<CarouselImages> {
  List<dynamic> imgs = [];

  int _current = 0;

  showImage(String image) {
    return Image.network(image);
    // return Image.memory(base64Decode(image));
  }

  @override
  void initState() {
    imgs = widget.house.propertyImages.map((e) => showImage(e.path)).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.265,
      child: Carousel(
        images: imgs,
        dotSize: 5,
        dotBgColor: Colors.transparent,
        dotIncreasedColor: kPrimaryColor,
        dotColor: white,
        autoplay: false,
        onImageChange: (index, reason) {
          setState(() {
            _current = index;
          });
        },
      ),
    );
  }
}
