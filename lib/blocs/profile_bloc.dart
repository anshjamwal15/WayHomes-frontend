import 'dart:async';

import 'package:dumper/model/profile_model.dart';
import 'package:dumper/networking/api_response.dart';
import 'package:dumper/repository/profile_repository.dart';

class ProfileBloc {
  ProfileRepository _profileRepository;

  StreamController _profileController;

  StreamSink<ApiResponse<Profile>> get profileDetailSink =>
      _profileController.sink;

  Stream<ApiResponse<Profile>> get profileDetailStream =>
      _profileController.stream;



  fetchUserProfile(int userId) async {
    profileDetailSink.add(ApiResponse.loading('Fetching Details'));
    try {
      Profile details = await _profileRepository.fetchUserProfile(userId);
      profileDetailSink.add(ApiResponse.completed(details));
    } catch (e) {
      profileDetailSink.add(ApiResponse.error(e.toString()));
    }
  }

  updateUserProfile(
      int userId, String email, String username, String password) async {
    profileDetailSink.add(ApiResponse.loading('Fetching Details'));
    try {
      final body = {"email": email, "username": username, "password": password};
      dynamic response =
          await _profileRepository.updateUserProfile(userId, body);
      profileDetailSink.add(ApiResponse.completed(response));
    } catch (e) {
      profileDetailSink.add(ApiResponse.error(e.toString()));
    }
  }

  dispose() {
    _profileController?.close();
  }
}
final profileBloc = ProfileBloc();
