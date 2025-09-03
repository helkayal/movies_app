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
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY4Yjg0OTBjNWQ5YzQ0MjM4MTJlMDdkMiIsImVtYWlsIjoiaGVsa2F5YWxAZ21haWwuY29tIiwiaWF0IjoxNzU2OTA3ODI2fQ.j6fkcErvvsLS74l55JriWwWoKOm35H7Xpx6AERQTzn0";
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
      emit(ProfileError(e.toString()));
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
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> deleteProfile() async {
    emit(ProfileLoading());
    try {
      await repository.deleteProfile();
      emit(ProfileDeleted());
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
