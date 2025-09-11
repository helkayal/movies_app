import 'package:flutter/material.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/core/theme/app_text_styles.dart';

extension ContextX on BuildContext {
  double get height => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;

  //snake bar helper
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message,style: AppTextStyles.whiteRegular16.copyWith(color: AppColors.darkGrey),),
        backgroundColor: isError ? AppColors.red : AppColors.yellow,
      ),
    );
  }

  //CircularIndicator helper
  void showLoading() {
    showDialog(
      context: this,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(color: AppColors.yellow),
        );
      },
    );
  }
}
