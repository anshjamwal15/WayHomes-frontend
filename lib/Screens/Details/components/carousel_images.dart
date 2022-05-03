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
    return Image.memory(base64Decode(image));
  }

  @override
  void initState() {
    imgs = widget.house.propertyImages.map((e) => showImage(e.data)).toList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
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
        // images: [
          

          
        //   // showImage(widget.house.propertyImages[0].data),
        //   // showImage(widget.house.propertyImages[1].data),
        //   // showImage(widget._houseDetails.singleProperty.propertyImages[1].data),
        //   // NetworkImage(
        //   //   widget.imagesListUrl[0],
        //   // ),
        //   // NetworkImage(
        //   //   widget.imagesListUrl[0],
        //   // ),
        //   // NetworkImage(
        //   //   widget.imagesListUrl[0],
        //   // ),
        //   // NetworkImage(
        //   //   widget.imagesListUrl[0],
        //   // ),
        // ],
      ),
    );
  }
}
