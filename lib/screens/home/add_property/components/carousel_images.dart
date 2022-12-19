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
    'assets/images/input.png'
  ];
  List<dynamic> imgs = [];

  int _current = 0;

  showImage(String image) {
    return Image.asset(image);
  }

  @override
  void initState() {
    imgs = data.map((e) => showImage(e)).toList();
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
