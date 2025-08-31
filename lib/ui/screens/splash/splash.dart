import 'package:flutter/material.dart';
import 'package:movies_app/ui/utils/app_assets.dart';
import 'package:movies_app/ui/utils/app_routes.dart';
import 'package:movies_app/ui/utils/app_text_styles.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(context, AppRoutes.onboarding);
      }
    });
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
