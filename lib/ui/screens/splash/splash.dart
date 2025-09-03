import 'package:flutter/material.dart';
import 'package:movies_app/ui/utils/app_assets.dart';
import 'package:movies_app/ui/utils/app_routes.dart';
import 'package:movies_app/ui/utils/app_text_styles.dart';
import 'package:movies_app/data/datasources/onbording/onborading_ds_impl.dart';
import 'package:movies_app/data/repositories/onboarding_repository/onboarding_repository.dart';
import 'package:movies_app/data/repositories/onboarding_repository/onboarding_repository_impl.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late OnboardingRepository _repository;

  @override
  void initState() {
    super.initState();
    _initRepository();
  }

  Future<void> _initRepository() async {
    _repository = OnboardingRepositoryImpl(OnboardingDataSourceImpl());
    _navigate();
  }

  Future<void> _navigate() async {
    // _repository.clearOnboardingData(); // For testing purposes
    await Future.delayed(const Duration(seconds: 2));
    final completed = await _repository.isOnboardingCompleted();
    if (!mounted) return;
    if (completed) {
      Navigator.pushReplacement(context, AppRoutes.home);
    } else {
      Navigator.pushReplacement(context, AppRoutes.onboardingIntro);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Spacer(),
            Image.asset(
              AppAssets.logo,
              height: height * 0.15,
              fit: BoxFit.contain,
            ),
            Spacer(),
            Image.asset(AppAssets.route, height: height * 0.1),
            Text(
              'Supervised by Mohamed Nabil',
              style: AppTextStyles.whiteRegular16,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
