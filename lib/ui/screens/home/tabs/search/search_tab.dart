import 'package:flutter/material.dart';
import 'package:movies_app/ui/utils/app_text_styles.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Search Tab', style: AppTextStyles.whiteBold36)),
    );
  }
}
