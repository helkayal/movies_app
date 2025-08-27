import 'package:flutter/material.dart';
import 'package:movies_app/ui/utils/app_text_styles.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Register Screen', style: AppTextStyles.whiteBold36),
      ),
    );
  }
}
