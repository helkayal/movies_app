import 'package:flutter/material.dart';
import 'package:movies_app/ui/utils/app_text_styles.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Profile Tab', style: AppTextStyles.whiteBold36),
      ),
    );
  }
}
