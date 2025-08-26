import 'package:flutter/material.dart';
import 'package:movies_app/ui/utils/app_colors.dart';
import 'package:movies_app/ui/utils/app_text_styles.dart';

abstract final class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.black,
      primary: AppColors.black,
      secondary: AppColors.white,
    ),
    scaffoldBackgroundColor: AppColors.black,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.black,
      titleTextStyle: AppTextStyles.yelowRegular16,
    ),
  );

  static ThemeData darkTheme = lightTheme;
}
