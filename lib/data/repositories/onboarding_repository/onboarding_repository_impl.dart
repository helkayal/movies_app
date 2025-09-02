import 'package:movies_app/data/datasources/onborading_ds.dart';
import 'package:movies_app/data/repositories/onboarding_repository/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingDataSource localDataSource;

  OnboardingRepositoryImpl(this.localDataSource);

  @override
  Future<void> setOnboardingCompleted() {
    return localDataSource.setOnboardingCompleted();
  }

  @override
  Future<bool> isOnboardingCompleted() {
    return localDataSource.isOnboardingCompleted();
  }

  @override
  Future<void> clearOnboardingData() {
    return localDataSource.clearOnboardingData();
  }
}
