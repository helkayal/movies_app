import 'package:flutter/material.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/core/theme/app_text_styles.dart';
import 'package:movies_app/l10n/app_localizations.dart';

extension ContextX on BuildContext {
  double get height => MediaQuery.sizeOf(this).height;
  double get width => MediaQuery.sizeOf(this).width;
  AppLocalizations get loc => AppLocalizations.of(this)!;

  //snake bar helper
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 500),
        content: Text(
          message,
          style: AppTextStyles.blackBold20.copyWith(fontSize: 16)
        ),
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
