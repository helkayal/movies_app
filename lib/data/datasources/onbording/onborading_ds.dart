abstract class OnboardingDataSource {
  Future<void> setOnboardingCompleted();
  Future<bool> isOnboardingCompleted();
  Future<void> clearOnboardingData();
}
