import 'package:movies_app/data/datasources/onbording/onborading_ds.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingDataSourceImpl implements OnboardingDataSource {
  static const String _onboardingKey = "isOnboardingCompleted";

  @override
  Future<void> setOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }

  @override
  Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }

  @override
  Future<void> clearOnboardingData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_onboardingKey);
  }
}
