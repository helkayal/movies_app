import 'package:movies_app/core/utils/shared_prefs_utils.dart';
import 'package:movies_app/data/datasources/onbording/onborading_ds.dart';

class OnboardingDataSourceImpl implements OnboardingDataSource {
  static const String _onboardingKey = "isOnboardingCompleted";

  @override
  Future<void> setOnboardingCompleted() async {
    await SharedPrefsUtils.init();
    await SharedPrefsUtils.saveBool(_onboardingKey, true);
  }

  @override
  Future<bool> isOnboardingCompleted() async {
    await SharedPrefsUtils.init();
    return SharedPrefsUtils.getBool(_onboardingKey) ?? false;
  }

  @override
  Future<void> clearOnboardingData() async {
    await SharedPrefsUtils.init();
    await SharedPrefsUtils.remove(_onboardingKey);
  }
}
