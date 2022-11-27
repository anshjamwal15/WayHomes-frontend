import 'package:dumper/model/category_model.dart';
import 'package:flutter/material.dart';
import '../../../constants/constants.dart';

class Categories extends StatefulWidget {
  Categories({Key key, this.categoriesList}) : super(key: key);
  List<CategoryModel> categoriesList;
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  void initState() {
    super.initState();
  }

  int selectedCategoryIndex = 0;
  List<String> categoryList = [
    'For Sale',
    '3-4 bed room',
    'Garages',
    'Modular kitchen'
  ];

  Widget _buildCategory(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
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
    );
  }
}
