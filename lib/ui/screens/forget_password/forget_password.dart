import 'package:flutter/material.dart';
import '../../../core/theme/app_text_styles.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Forget Password Screen', style: AppTextStyles.whiteBold36),
      ),
    );
  }
}
