abstract class ProfileRepository {
  Future<Map<String, dynamic>> getProfile();
  Future<Map<String, dynamic>> updateProfile({
    required String name,
    required String email,
    required int avatar,
    required String phone,
  });
  Future<void> deleteProfile();
}
