import 'package:carousel_pro/carousel_pro.dart';
import 'package:dumper/components/loading_circle.dart';
import 'package:dumper/constants/constants.dart';
import 'dart:io';
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
  bool showLoading = false;
  int _current = 0;
  List<dynamic> data = ['assets/images/input.png'];
  List<dynamic> imgs = [];
  List<String> imgList = [];

  showImage(String image) {
    if (image.contains('assets/images')) {
      return Image.asset(image);
    }
    return Image.file(File(image));
  }

  @override
  void initState() {
    imgs = data.map((e) => showImage(e)).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          showLoading
              ? Stack(
                  alignment: Alignment.center,
                  children: const [
                    Center(
                      child: CircularProgressIndicator(),
                    )
                  ],
                )
              : Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
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
                        ),
                        CustomAppBar(
                          imgList: (p0) {
                            setState(() {
                              imgs = p0.map((e) => showImage(e)).toList();
                              imgList = p0;
                            });
                          },
                        ),
                      ],
                    ),
                    HouseDetails(
                      imgList: imgList,
                      showLoading: (p0) {
                        setState(() {
                          showLoading = p0;
                        });
                      },
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
