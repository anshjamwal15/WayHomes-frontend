import 'package:dumper/model/profile_model.dart';
import 'package:dumper/networking/api_base_helper.dart';

class ProfileRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<dynamic> fetchUserProfile(int userId) async {
    final response = await _helper.get("/api/auth/user/get-user-info/$userId");

    return Profile.fromJson(response);
  }

  Future<String> updateUserProfile(int userId, Map<String, String> body) async {
    final response = await _helper.post(
      "/api/auth/user/update-profile",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    return "Profile updated";
  }
}
