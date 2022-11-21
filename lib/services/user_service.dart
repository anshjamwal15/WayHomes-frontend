import 'dart:convert';
import 'package:dumper/main.dart';
import 'package:http/http.dart' as http;

class UserService {

  // Sign-Up
  Future<String> signUp(String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$SERVER_IP/api/auth/signup'),
      body: jsonEncode(
        <String, String>{
          'username': username,
          'email': email,
          'password': password
        },
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if(response.statusCode == 200) {
      return response.body;
    }
    return "Failed to Sign-up";
  }

  // Log-In
  Future<Map<String, dynamic>> logInAttempt(String username, String password) async {
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
}