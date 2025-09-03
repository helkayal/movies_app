import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final String text;
  final TextStyle textStyle;
  final Function() onClick;
  final Color textColor;
  final Widget? icon;

  const CustomButton({
    super.key,
    required this.text,
    required this.onClick,
    this.icon,
    this.backgroundColor = AppColors.yellow,
    this.borderColor = AppColors.yellow,
    this.textStyle = AppTextStyles.blackRegular20,
    this.textColor = AppColors.black,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: borderColor, width: 2),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text, style: textStyle.copyWith(color: textColor)),
          if (icon != null) const SizedBox(width: 5),
          if (icon != null) icon!,
        ],
      ),
    );
  }
}
