import 'dart:async';

import 'package:dumper/networking/api_response.dart';
import 'package:dumper/repository/signup_repository.dart';

class UserSignUpBloc {
  SignUpRepository _signUpRepository;

  StreamController _signUpController;

  StreamSink<ApiResponse<String>> get signUpSink => _signUpController.sink;

  Stream<ApiResponse<String>> get signUpStream => _signUpController.stream;

  UserSignUpBloc(Map<String, String> body) {
    _signUpController = StreamController<ApiResponse<String>>();
    _signUpRepository = SignUpRepository();
  }

  userSignUp(String username, String email, String password) async {
    signUpSink.add(ApiResponse.loading('Fetching Details'));
    try {
      final body = {"username": username, "email": email, "password": password};
      dynamic response = await _signUpRepository.signUpUser(body);
    } catch (e) {
      signUpSink.add(ApiResponse.error(e.toString()));
    }
  }

  dispose() {
    _signUpController?.close();
  }
}
