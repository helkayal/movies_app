import 'package:flutter/material.dart';
import 'package:movies_app/ui/utils/app_text_styles.dart';

class BrowseTab extends StatelessWidget {
  const BrowseTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Browse Tab', style: AppTextStyles.whiteBold36)),
    );
  }
}
