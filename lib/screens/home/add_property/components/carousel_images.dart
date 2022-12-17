import 'package:carousel_pro/carousel_pro.dart';
import 'package:dumper/constants/constants.dart';
import 'package:flutter/material.dart';

class CarouselImages extends StatefulWidget {
  const CarouselImages({Key key}) : super(key: key);

  @override
  _CarouselImagesState createState() => _CarouselImagesState();
}

class _CarouselImagesState extends State<CarouselImages> {
  List<dynamic> data = [
    'https://is1-3.housingcdn.com/4f2250e8/41114616c8d9ff3cd729250bccb6ecf0/v3/large/godrej_nest-sector_150-noida-godrej_properties_ltd.jpg'
  ];

  List<dynamic> imgs = [];

  int _current = 0;

  showImage(String image) {
    return Image.network(image);
  }

  @override
  void initState() {
    imgs = data.map((e) => showImage(e)).toList();
    // imgs = widget.house.propertyImages.map((e) => showImage(e.path)).toList();
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
