import 'package:flutter/material.dart';
import 'package:movies_app/ui/utils/app_text_styles.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Onboarding Screen', style: AppTextStyles.whiteBold36),
      ),
    );
  }
}
