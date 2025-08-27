import 'package:flutter/material.dart';
import 'package:movies_app/ui/utils/app_text_styles.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Splash Screen', style: AppTextStyles.whiteBold36),
      ),
    );
  }
}
