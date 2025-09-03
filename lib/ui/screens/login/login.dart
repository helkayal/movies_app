import 'package:flutter/material.dart';
import '../../../core/theme/app_text_styles.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Login Screen', style: AppTextStyles.whiteBold36),
      ),
    );
  }
}
