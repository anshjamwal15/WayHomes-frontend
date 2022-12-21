import 'package:dumper/services/helper_functions.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dumper/main.dart';
import 'package:dumper/model/category_model.dart';
import 'package:http/http.dart' as http;

class PropertyService {
  Future<List<CategoryModel>> getCategories() async {
    final Uri url = Uri.parse("$SERVER_IP/api/auth/property/tags");
    final response =
        await http.get(url, headers: {"ContentType": "application/json"});
    if (response.statusCode == 200) {
      final result = categoryModelFromJson(response.body);
      return result;
    }
    return <CategoryModel>[];
  }

  Future<String> uploadProperty(
      Map<String, String> data, List<String> imgList) async {
    if (data != null &&
        data.isNotEmpty &&
        imgList != null &&
        imgList.isNotEmpty) {
      int userId = await HelperFunctions.getUserIdSharedPreference();
      Uri url = Uri.parse("$SERVER_IP/api/auth/property/createproperty");
      var requestData = http.MultipartRequest('POST', url);
      requestData.fields['sqFeet'] = data['sqFeet'];
      requestData.fields['bedrooms'] = data['bedrooms'];
      requestData.fields['bathrooms'] = data['bathrooms'];
      requestData.fields['garages'] = data['garages'];
      requestData.fields['price'] = data['price'];
      requestData.fields['description'] = data['description'];
      requestData.fields['address'] = data['address'];
      requestData.fields['userId'] = userId.toString();
      requestData.fields['tags'] = data['tags'];
      for (int i = 0; i < imgList.length; i++) {
        final http.MultipartFile newImage =
            await http.MultipartFile.fromPath('files', imgList[i]);
        requestData.files.add(newImage);
      }
      final response = await requestData.send();
      if (response.statusCode == 200) {
        return "success";
      }
    }
    return "unsuccessful";
  }
}
