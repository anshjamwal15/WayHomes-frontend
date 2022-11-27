import 'package:dumper/model/property_model.dart';
import 'package:dumper/services/helper_functions.dart';
import 'package:http/http.dart' as http;
import 'package:dumper/main.dart';
import 'package:dumper/model/category_model.dart';

class PropertyService {

  Future<List<CategoryModel>> getCategories() async {
    final Uri url = Uri.parse("$SERVER_IP/api/auth/property/tags");
    final response = await http.get(url, headers: {"ContentType": "application/json"});
    if(response.statusCode == 200) {
      final result = categoryModelFromJson(response.body);
      return result;
    }
    return <CategoryModel>[];
  }

  Future<PropertyModel> getProperties() async {
    final email = await HelperFunctions.getUserEmailSharedPreference();
    final Uri url = Uri.parse("$SERVER_IP/api/auth/property/all?email=$email&tag=");
    final response = await http.get(url, headers: {"ContentType": "application/json"});
    if(response.statusCode == 200) {
      final result = propertyModelFromJson(response.body);
      return result;
    }
    return propertyModelFromJson(response.body);
  }
}