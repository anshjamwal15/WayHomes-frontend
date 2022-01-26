import 'dart:convert';

import 'package:dumper/constants/Api_Data.dart';
import 'package:dumper/model/property_model.dart';
import 'package:http/http.dart' as http;

class API_Manager {
  Future<PropertyModel> getProperties() async {
    var client = http.Client();
    PropertyModel propertyModel;

    try {
      var response = await client.get(ApiData.property_url);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = jsonDecode(jsonString);
        propertyModel = PropertyModel.fromJson(jsonMap);
      }
    } on Exception {
      return propertyModel;
    }
    return propertyModel;
  }
}
