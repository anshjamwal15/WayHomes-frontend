import 'package:dumper/main.dart';
import 'package:dumper/model/property_model.dart';
import 'package:dumper/services/helper_functions.dart';
import 'package:http/http.dart' as http;

class HomePageService {
  static Future<bool> likeAndDislike(int propertyId) async {
    final email = await HelperFunctions.getUserEmailSharedPreference();
    final response = await http.post(
      Uri.parse(
          "$SERVER_IP/api/auth/user/likedislike/$propertyId?email=$email"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  // static Stream<List<Content>> getNewData(Duration refreshTime) async* {
  //   while (true) {
  //     await Future.delayed(refreshTime);
  //     yield await getData();
  //   }
  // }
}
