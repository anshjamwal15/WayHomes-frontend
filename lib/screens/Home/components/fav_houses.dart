import 'package:dumper/Screens/Details/details_screen.dart';
import 'package:dumper/constants/constants.dart';
import 'package:dumper/main.dart';
import 'package:dumper/model/fav_house_model.dart';
import 'package:dumper/model/property_model.dart';
import 'package:dumper/services/helper_functions.dart';
import 'package:dumper/services/home_page_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FavHouses extends StatefulWidget {
  const FavHouses({Key key}) : super(key: key);
  @override
  FavHousesState createState() => FavHousesState();
}

class FavHousesState extends State<FavHouses> {
  int selectedCategoryIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();

  Future<List<FavHouseModel>> propertyFuture;
  Future<List<FavHouseModel>> getProperties() async {
    final email = await HelperFunctions.getUserEmailSharedPreference();
    Uri url = Uri.parse(
        "$SERVER_IP/api/auth/property/likedproperties?email=yoko@gmail.com");
    final response =
        await http.get(url, headers: {"ContentType": "application/json"});
    if (response.statusCode == 200) {
      return favHouseModelFromJson(response.body);
    }
    return <FavHouseModel>[];
  }

  showImage(String image) {
    return Image.network(image);
  }

  @override
  void initState() {
    propertyFuture = getProperties();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldkey,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: appPadding,
                  right: appPadding,
                  top: appPadding * 2,
                ),
                child: SizedBox(
                  height: size.height * 0.22,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'City',
                            style: TextStyle(
                                color: kPrimaryColor.withOpacity(0.4),
                                fontSize: 18),
                          ),
                          SizedBox(height: size.height * 0.01),
                          const Text(
                            'Noida',
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: propertyFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
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
                                    horizontal: appPadding,
                                    vertical: appPadding / 2),
                                child: SizedBox(
                                  height: 250,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: SizedBox(
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
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: IconButton(
                                                icon: data.isFav
                                                    ? const Icon(
                                                        Icons.favorite_rounded,
                                                        color: kPrimaryColor,
                                                      )
                                                    : const Icon(
                                                        Icons
                                                            .favorite_border_rounded,
                                                        color: kPrimaryColor,
                                                      ),
                                                onPressed: () {
                                                  HomePageService
                                                      .likeAndDislike(data.id);
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
                                                  color:
                                                      black.withOpacity(0.4)),
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
                      );
                    } else {
                      return const Opacity(opacity: 0.64);
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      // drawer: NavigationDrawerWidget(
      //   username: widget.username,
      //   email: widget.email,
      // ),
    );
  }
}
