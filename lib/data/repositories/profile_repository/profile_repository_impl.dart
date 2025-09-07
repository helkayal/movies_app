import 'package:movies_app/data/datasources/profile/profile_data_source.dart';
import 'package:movies_app/data/repositories/profile_repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource dataSource;

  ProfileRepositoryImpl(this.dataSource);

  @override
  Future<Map<String, dynamic>> getProfile() {
    return dataSource.getProfile();
  }

  @override
  Future<Map<String, dynamic>> updateProfile({
    required String name,
    required String email,
    required int avatar,
    required String phone,
  }) {
    return dataSource.updateProfile(
      name: name,
      email: email,
      avatar: avatar,
      phone: phone,
    );
  }

  @override
  Future<void> deleteProfile() {
    return dataSource.deleteProfile();
  }
}
