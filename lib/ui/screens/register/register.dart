import 'package:flutter/material.dart';
import '../../../core/theme/app_text_styles.dart';

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
