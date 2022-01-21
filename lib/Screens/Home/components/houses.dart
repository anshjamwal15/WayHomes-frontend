import 'package:dumper/Screens/Details/details_screen.dart';
import 'package:dumper/constants.dart';
import 'package:dumper/data/data.dart';
import 'package:dumper/model/house.dart';
import 'package:flutter/material.dart';

class Houses extends StatefulWidget {
  const Houses({Key key}) : super(key: key);

  @override
  _HousesState createState() => _HousesState();
}

class _HousesState extends State<Houses> {
  Widget _buildHouse(BuildContext context, int index) {
    Size size = MediaQuery.of(context).size;
    House house = houseList[index];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailsScreen(house: house),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: appPadding, vertical: appPadding / 2),
        child: Container(
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image(
                      height: 180,
                      width: size.width,
                      fit: BoxFit.cover,
                      image: AssetImage(house.imageUrl),
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
                        icon: house.isFav
                            ? const Icon(
                                Icons.favorite_rounded,
                                color: kPrimaryColor,
                              )
                            : const Icon(
                                Icons.favorite_border_rounded,
                                color: kPrimaryColor,
                              ),
                        onPressed: () {
                          setState(() {
                            house.isFav = !house.isFav;
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
                    '\₹${house.price.toStringAsFixed(4)}',
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
                      house.address,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 15, color: black.withOpacity(0.4)),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '${house.bedRooms} bedrooms / ',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    ' ${house.bathRooms} bathrooms / ',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    ' ${house.sqFeet} sqft  ',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: houseList.length,
        itemBuilder: (context, index) {
          return _buildHouse(context, index);
        },
      ),
    );
  }
}
