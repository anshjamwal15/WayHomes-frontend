import 'package:dumper/constants/constants.dart';
import 'package:flutter/material.dart';

class BottomButtons extends StatelessWidget {
  const BottomButtons({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(bottom: appPadding),
      child: Container(
        width: size.width * 0.4,
        height: 60,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: darkBlue.withOpacity(0.6),
              offset: const Offset(0, 10),
              blurRadius: 10,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              (Icons.map_outlined),
              color: white,
            ),
            Text(
              'Map View',
              style: TextStyle(
                color: white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
