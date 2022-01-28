import 'dart:convert';

import 'package:dumper/model/property_model.dart';
import 'package:http/http.dart' as http;

abstract class ServiceApi {
  Future<PropertyModel> getProperty();
}

class PropertyService extends ServiceApi {
  Uri url = Uri.parse("http://192.168.0.126:8080/api/auth/property/all");

  PropertyModel propertyModel;

  @override
  Future<PropertyModel> getProperty() async {
    try {
      var response =
          await http.get(url, headers: {"ContentType": "application/json"});
      var json = response.body;
      var jsonMap = jsonDecode(json);
      propertyModel = PropertyModel.fromJson(jsonMap);
    } catch (e) {
      throw Exception("Data not fetched");
    }
    return propertyModel;
  }
}
