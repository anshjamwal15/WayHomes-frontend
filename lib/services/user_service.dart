import 'dart:convert';
import 'package:dumper/main.dart';
import 'package:dumper/services/helper_functions.dart';
import 'package:http/http.dart' as http;
import 'package:dumper/model/profile_model.dart';

class UserService {
  // Sign-Up
  Future<String> signUp(
      String username, String email, String password, String type) async {
    final response = await http.post(
      Uri.parse('$SERVER_IP/api/auth/signup'),
      body: jsonEncode(
        <String, String>{
          'username': username,
          'email': email,
          'password': password,
          'type': type
        },
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    }
    return "Failed to Sign-up";
  }

  // Log-In
  Future<Map<String, dynamic>> logInAttempt(
      String username, String password) async {
    final response = await http.post(
      Uri.parse('$SERVER_IP/api/auth/signin'),
      body: jsonEncode(
        <String, String>{'username': username, 'password': password},
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return json.decode(response.body);
    }
  }

  // Update user
  Future<String> updateUserProfile(Map<String, String> data) async {
    final email = await HelperFunctions.getUserEmailSharedPreference();

    final Uri url =
        Uri.parse('$SERVER_IP/api/auth/user/updateprofile?email=$email');

    final response = await http.post(
      url,
      body: jsonEncode(data),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    }
    return "Failed to update";
  }

  //Fetch User
  Future<Profile> fetchUserData() async {
    final email = await HelperFunctions.getUserEmailSharedPreference();

    final Uri url =
        Uri.parse("$SERVER_IP/api/auth/user/getuserinfo?email=$email");

    final response =
        await http.get(url, headers: {"ContentType": "application/json"});

    if (response.statusCode == 200) {
      return Profile.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to fetch user');
  }
}
