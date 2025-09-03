import 'package:movies_app/core/services/api/profile_api_service.dart';
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
    required int avatar,
  }) async {
    return await apiService.updateProfile({"name": name, "avaterId": avatar});
  }

  @override
  Future<void> deleteProfile() async {
    await apiService.deleteProfile();
  }
}
