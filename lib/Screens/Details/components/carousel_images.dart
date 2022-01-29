import 'package:carousel_pro/carousel_pro.dart';
import 'package:dumper/constants/constants.dart';
import 'package:flutter/material.dart';

class CarouselImages extends StatefulWidget {
  List<String> imagesListUrl = [
    "https://www.commercialproperty.review/wp-content/uploads/2020/08/ATS-Greens-Village-Aparments-Sector-93-Noida.jpg"
  ];

  CarouselImages(this.imagesListUrl);

  @override
  _CarouselImagesState createState() => _CarouselImagesState();
}

class _CarouselImagesState extends State<CarouselImages> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.35,
      child: Carousel(
        dotSize: 5,
        dotBgColor: Colors.transparent,
        dotIncreasedColor: kPrimaryColor,
        dotColor: white,
        autoplay: false,
        images: [
          NetworkImage(
            widget.imagesListUrl[0],
          ),
          NetworkImage(
            widget.imagesListUrl[0],
          ),
          NetworkImage(
            widget.imagesListUrl[0],
          ),
          NetworkImage(
            widget.imagesListUrl[0],
          ),
          NetworkImage(
            widget.imagesListUrl[0],
          ),
          NetworkImage(
            widget.imagesListUrl[0],
          ),
        ],
      ),
    );
  }
}
