
import 'dart:async';

import 'package:dumper/networking/api_response.dart';
import 'package:dumper/repository/login_repository.dart';

class UserLoginBloc {

  LoginRepository _loginRepository;

  StreamController _loginController;

  StreamSink<ApiResponse<String>> get loginSink => _loginController.sink;

  Stream<ApiResponse<String>> get loginStream => _loginController.stream;

  UserLoginBloc(Map<String, String> body) {
    _loginController = StreamController<ApiResponse<String>>();
    _loginRepository = LoginRepository();
}

  userLogin(String username, String password) async {
    loginSink.add(ApiResponse.loading('Fetching Details'));
    try{
      final body = {"username": username, "password": password};
      dynamic response = await _loginRepository.loginUser(body);
      loginSink.add(ApiResponse.completed(response));
    } catch (e) {
      loginSink.add(ApiResponse.error(e.toString()));
    }
  }

  dispose() {
    _loginController?.close();
  }
}