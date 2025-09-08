import 'package:movies_app/data/datasources/Api/profile_api_service.dart';
import 'package:movies_app/data/datasources/profile/profile_data_source.dart';

class ProfileDataSourceImpl implements ProfileDataSource {
  final ProfileApiService apiService;

  ProfileDataSourceImpl(this.apiService);

  @override
  Future<Map<String, dynamic>> getProfile() async {
    return await apiService.getProfile();
  }

  @override
  Future<Map<String, dynamic>> updateProfile({
    required String name,
    required String email,
    required int avatar,
    required String phone,
  }) async {
    return await apiService.updateProfile({
      "name": name,
      "email": email,
      "avaterId": avatar,
      "phone": phone,
    });
  }

  @override
  Future<void> deleteProfile() async {
    await apiService.deleteProfile();
  }

  @override
  Future<Map<String, dynamic>> resetPassword({
    required String oldPassword,
    required String newPassword,
  }) {
    return apiService.resetPassword({
      "oldPassword": oldPassword,
      "newPassword": newPassword,
    });
  }
}
