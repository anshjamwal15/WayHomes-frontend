import 'package:dumper/Screens/Details/details_screen.dart';
import 'package:dumper/constants/constants.dart';
import 'package:dumper/main.dart';
import 'package:dumper/model/category_model.dart';
import 'package:dumper/model/property_model.dart';
import 'package:dumper/services/helper_functions.dart';
import 'package:dumper/services/home_page_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Houses extends StatefulWidget {
  Houses({Key key, this.categoriesList}) : super(key: key);
  List<CategoryModel> categoriesList;

  @override
  HousesState createState() => HousesState();
}

class HousesState extends State<Houses> {
  int selectedCategoryIndex = 0;

  Future<List<Content>> propertyFuture;

  Future<List<Content>> getProperties(String tagName) async {
    final email = await HelperFunctions.getUserEmailSharedPreference();
    Uri url;
    if (tagName.isNotEmpty) {
      url = Uri.parse(
          "$SERVER_IP/api/auth/property/all?email=$email&tag=$tagName");
    } else {
      url = Uri.parse("$SERVER_IP/api/auth/property/all?email=$email&tag=");
    }
    final response =
        await http.get(url, headers: {"ContentType": "application/json"});
    if (response.statusCode == 200) {
      final result = propertyModelFromJson(response.body);
      return result.content;
    }
    return <Content>[];
  }

  showImage(String image) {
    return Image.network(image);
  }

  changeFilter(String tagName) {
    setState(() {
      propertyFuture = getProperties(tagName);
    });
  }

  // Category Widget
  Widget _buildCategory(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        changeFilter(widget.categoriesList[index].name);
        setState(() {
          selectedCategoryIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(right: appPadding / 3),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: appPadding / 2),
          decoration: BoxDecoration(
            color: selectedCategoryIndex == index
                ? kPrimaryColor
                : kPrimaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              widget.categoriesList[index].name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedCategoryIndex == index ? white : black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    propertyFuture = getProperties("All");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: propertyFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: appPadding,
                  top: appPadding / 2,
                  bottom: appPadding,
                ),
                child: SizedBox(
                  height: size.height * 0.05,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.categoriesList.length,
                    itemBuilder: (context, index) {
                      return _buildCategory(context, index);
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailsScreen(
                              house: snapshot.data[index],
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: appPadding, vertical: appPadding / 2),
                        child: SizedBox(
                          height: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      child: showImage(
                                          data.propertyImages[0].path),
                                      height: 200,
                                      width: size.width,
                                    ),
                                  ),
                                  Positioned(
                                    right: appPadding / 2,
                                    top: appPadding / 2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: IconButton(
                                        icon: data.isFav
                                            ? const Icon(
                                                Icons.favorite_rounded,
                                                color: kPrimaryColor,
                                              )
                                            : const Icon(
                                                Icons.favorite_border_rounded,
                                                color: kPrimaryColor,
                                              ),
                                        onPressed: () {
                                          HomePageService.likeAndDislike(
                                              data.id);
                                          setState(() {
                                            data.isFav = !data.isFav;
                                          });
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    '\₹${data.price}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      data.description,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: black.withOpacity(0.4)),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${data.bedrooms} bedrooms / ',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    ' ${data.bathrooms} bathrooms / ',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    ' ${data.sqFeet} sqft  ',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return const Opacity(opacity: 0.64);
        }
      },
    );
  }
}
