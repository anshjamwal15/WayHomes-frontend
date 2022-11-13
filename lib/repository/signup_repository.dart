import 'package:dumper/networking/api_base_helper.dart';

class SignUpRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<String> signUpUser(Map<String, String> body) async {
    final response = await _helper.post(
      "/api/auth/signup",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    return "Signed up";
  }
}
