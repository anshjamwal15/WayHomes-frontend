import 'package:dumper/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key key, this.isFav}) : super(key: key);

  final bool isFav;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(
        left: appPadding,
        right: appPadding,
        top: appPadding,
      ),
      child: SizedBox(
        height: size.height * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: white,
                  border: Border.all(color: white.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: kPrimaryColor,
                ),
              ),
            ),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: white,
                border: Border.all(color: white.withOpacity(0.4)),
                borderRadius: BorderRadius.circular(15),
              ),
              child: IconButton(
                icon: widget.isFav
                    ? const Icon(
                        Icons.favorite_rounded,
                        color: kPrimaryColor,
                      )
                    : const Icon(
                        Icons.favorite_border_rounded,
                        color: kPrimaryColor,
                      ),
                onPressed: () {

                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
