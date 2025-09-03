import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

abstract final class AppTheme {
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.black,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.black,
      titleTextStyle: AppTextStyles.yelowRegular16,
    ),
  );
}
