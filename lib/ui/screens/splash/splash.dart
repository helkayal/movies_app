import 'package:movies_app/core/utils/constants/imports.dart';

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
              height: height * 0.1,
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
