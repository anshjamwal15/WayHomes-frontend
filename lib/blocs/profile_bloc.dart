
import 'dart:async';

import 'package:dumper/model/profile_model.dart';
import 'package:dumper/networking/api_response.dart';
import 'package:dumper/repository/profile_repository.dart';

class ProfileBloc {

  ProfileRepository _profileRepository;

  StreamController _profileController;

  StreamSink<ApiResponse<Profile>> get profileDetailSink => _profileController.sink;

  Stream<ApiResponse<Profile>> get profileDetailStream => _profileController.stream;

  ProfileBloc(userId) {
    _profileController = StreamController<ApiResponse<Profile>>();
    _profileRepository = ProfileRepository();
    fetchUserProfile(userId);
  }

  fetchUserProfile(int userId) async {
    profileDetailSink.add(ApiResponse.loading('Fetching Details'));
    try {
      Profile details = await _profileRepository.fetchUserProfile(userId);
      profileDetailSink.add(ApiResponse.completed(details));
    } catch (e) {
      profileDetailSink.add(ApiResponse.error(e.toString()));
    }
  }

  dispose() {
    _profileController?.close();
  }

}