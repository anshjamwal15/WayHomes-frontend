import 'package:dumper/model/profile_model.dart';
import 'package:dumper/networking/api_base_helper.dart';

class ProfileRepository {

  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<Profile> fetchUserProfile(int userId) async {
    
    final response = await _helper.get("/api/auth/user/get-user-info/$userId");

    return Profile.fromJson(response);
  }
}