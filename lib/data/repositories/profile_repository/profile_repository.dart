abstract class ProfileRepository {
  Future<Map<String, dynamic>> getProfile();
  Future<Map<String, dynamic>> updateProfile({
    required String name,
    required int avatar,
  });
  Future<void> deleteProfile();
}
