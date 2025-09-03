import 'package:flutter/material.dart';
import '../../../core/utils/constants/app_assets.dart';
import '../../../core/utils/constants/app_routes.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../widgets/custom_button.dart';

class OnboardingIntro extends StatelessWidget {
  const OnboardingIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.moviesPosters),
              fit: BoxFit.cover,
            ),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Find Your Next',
                style: AppTextStyles.whiteMediumd36,
                textAlign: TextAlign.center,
              ),
              Text(
                'Favorite Movie Here',
                style: AppTextStyles.whiteMediumd36,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Get access to a huge library of movies to suit all tastes. You will surely like it.',
                  style: AppTextStyles.lightGreyRegular20,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Explore Now',
                textStyle: AppTextStyles.blackSemiBold20,
                onClick: () {
                  Navigator.pushReplacement(context, AppRoutes.onboarding);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
