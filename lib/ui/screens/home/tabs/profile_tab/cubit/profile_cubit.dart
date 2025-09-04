import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/services/api/profile_api_service.dart';
import 'package:movies_app/data/datasources/profile/profile_data_source_impl.dart';
import 'package:movies_app/data/repositories/profile_repository/profile_repository_impl.dart';
import 'package:movies_app/model/user_dm.dart';
import 'package:movies_app/ui/screens/home/tabs/profile_tab/cubit/profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  late final ProfileRepositoryImpl repository;

  ProfileCubit() : super(ProfileInitial()) {
    // final token = SharedPrefsUtils.getString("token") ?? "";
    final token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4YjhhMmQ0MTY3MDRjYzg5NWNhYzI0MyIsImVtYWlsIjoiaGVsa2F5YWxAZ21haWwuY29tIiwiaWF0IjoxNzU2OTMwNzc4fQ.HRGvVM_qBlIRsxezd_rgnB-cIo-D4N_QPWpmGmZzqhI";
    final apiService = ProfileApiService(token: token);
    final dataSource = ProfileDataSourceImpl(apiService);
    repository = ProfileRepositoryImpl(dataSource);
  }

  Future<void> getProfile() async {
    emit(ProfileLoading());
    try {
      final response = await repository.getProfile();

      final userJson = response["data"];
      final user = UserDataModel.fromJson(userJson);

      emit(ProfileLoaded(user));
    } catch (e) {
      final errorMessage = _extractErrorMessage(e);
      emit(ProfileError(errorMessage));
    }
  }

  Future<void> updateProfile({
    required String name,
    required int avatar,
  }) async {
    emit(ProfileLoading());
    try {
      final profileJson = await repository.updateProfile(
        name: name,
        avatar: avatar,
      );
      final user = UserDataModel.fromJson(profileJson);
      emit(ProfileUpdated(user));
    } catch (e) {
      final errorMessage = _extractErrorMessage(e);
      emit(ProfileError(errorMessage));
    }
  }

  Future<void> deleteProfile() async {
    emit(ProfileLoading());
    try {
      await repository.deleteProfile();
      emit(ProfileDeleted());
    } catch (e) {
      final errorMessage = _extractErrorMessage(e);
      emit(ProfileError(errorMessage));
    }
  }

  String _extractErrorMessage(dynamic error) {
    try {
      final errorStr = error.toString();

      final jsonStart = errorStr.indexOf('{');
      if (jsonStart != -1) {
        final jsonPart = errorStr.substring(jsonStart);
        final decoded = jsonDecode(jsonPart);
        if (decoded is Map && decoded['message'] != null) {
          return decoded['message'];
        }
      }

      final decoded = jsonDecode(errorStr);
      if (decoded is Map && decoded['message'] != null) {
        return decoded['message'];
      }

      return errorStr.replaceAll("Exception: ", "");
    } catch (_) {
      return error.toString();
    }
  }
}
