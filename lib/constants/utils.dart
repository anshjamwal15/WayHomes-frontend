import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  String message = "Hello I am interested in property which posted on dumper";

  void openWhatsapp() async {
    var whatsapp = "Your number";
    var whatsappUrl_android =
        "whatsapp://send?phone=" + whatsapp + "&text=$message";
    var whatsappUrl_ios = "https://wa.me/$whatsapp?text=${Uri.parse(message)}";
    if (Platform.isIOS) {
      if (await canLaunch(whatsappUrl_ios)) {
        await launch(whatsappUrl_ios, forceSafariVC: false);
      } else {
        const SnackBar(
          content: Text("Whatsapp not installed"),
        );
      }
    } else {
      if (await canLaunch(whatsappUrl_android)) {
        await launch(whatsappUrl_android);
      } else {
        const SnackBar(
          content: Text("Whatsapp not installed"),
        );
      }
    }
  }

  static String myUsername = "";
}
