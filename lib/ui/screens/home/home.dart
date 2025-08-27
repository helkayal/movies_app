import 'package:flutter/material.dart';
import 'package:movies_app/ui/utils/app_text_styles.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Home Screen', style: AppTextStyles.whiteBold36),
      ),
    );
  }
}
