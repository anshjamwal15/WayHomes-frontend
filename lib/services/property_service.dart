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
}
