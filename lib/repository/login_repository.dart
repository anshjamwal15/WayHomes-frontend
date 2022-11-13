import 'package:dumper/networking/api_base_helper.dart';

class LoginRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<String> loginUser(Map<String, String> body) async {
    final response = await _helper.post(
      "/api/auth/signin",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    return "Logged In";
  }
}
