import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/secure_storage_utils.dart';
import 'package:movies_app/core/utils/shared_prefs_utils.dart';
import 'package:movies_app/data/datasources/Api/profile_api_service.dart';
import 'package:movies_app/data/datasources/profile/profile_data_source_impl.dart';
import 'package:movies_app/data/model/user_dm.dart';
import 'package:movies_app/data/repositories/profile_repository/profile_repository_impl.dart';
import 'package:movies_app/ui/screens/home/tabs/profile_tab/cubit/profile_states.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitial());

  Future<ProfileRepositoryImpl> _initRepository() async {
    // نحاول نجيب التوكن من التخزين
    String? token = await SecureStorageUtils().getToken();

    if (token == null) {
      throw Exception("No token found, please login again");
    }
    // // لو مفيش توكن، نجرب ناخد بيانات المستخدم من Firebase (حالة جوجل)
    // if (token == null) {
    //   final user = FirebaseAuth.instance.currentUser;
    //   if (user != null) {
    //     // نخزن على الأقل الإيميل عشان نستخدمه
    //     await SecureStorageUtils().saveToken(user.uid); // بنخزن الـ uid كتوكن بديل
    //     token = user.uid;
    //   } else {
    //     throw Exception("No token found, please login again");
    //   }
    // }

    final apiService = ProfileApiService(token: token);
    final dataSource = ProfileDataSourceImpl(apiService);
    return ProfileRepositoryImpl(dataSource);
  }

  Future<void> getProfile() async {
    emit(ProfileLoading());
    try {
      final repository = await _initRepository();
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
    required String email,
    required int avatar,
    required String phone,
  }) async {
    emit(ProfileLoading());
    try {
      final repository = await _initRepository();
      final profileJson = await repository.updateProfile(
        name: name,
        email: email,
        avatar: avatar,
        phone: phone,
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
      final repository = await _initRepository();
      await repository.deleteProfile();
      await SecureStorageUtils().logout();
      // نمسح التوكن كمان
      emit(ProfileDeleted());
    } catch (e) {
      final errorMessage = _extractErrorMessage(e);
      emit(ProfileError(errorMessage));
    }
  }

  Future<void> logOut() async {
    emit(ProfileLoading());
    try {
      await SecureStorageUtils().logout();
      await SharedPrefsUtils.saveBool("isGoogleLoggedIn", false);
      emit(LogedOut());
    } catch (e) {
      final errorMessage = _extractErrorMessage(e);
      emit(ProfileError(errorMessage));
    }
  }

  Future<void> resetPassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    emit(ProfileLoading());
    try {
      final repository = await _initRepository();
      await repository.resetPassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      emit(PasswordResetSuccess());
    } catch (e) {
      final errorMessage = e.toString().replaceFirst("Exception: ", "");
      emit(PasswordResetError(errorMessage));
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
