import 'dart:convert';

import 'package:dumper/main.dart';
import 'package:flutter/cupertino.dart';

class NetworkHandler {

  String baseUrl = SERVER_IP;

  String formater(String url) {
    return baseUrl + "/api/auth/" + url;
  }

  NetworkImage getImage(String imgUrl) {
    String url = formater(imgUrl);
    return NetworkImage(url);
  }

  Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }
}