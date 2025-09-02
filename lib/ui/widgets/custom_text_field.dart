import 'package:flutter/material.dart';
import 'package:movies_app/core/utils/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final Color hintColor;
  final Color backgroundColor;
  final Widget? prefixIcon;
  final Color? prefixIconColor;
  final double? prefixIconSize;
  final bool isPassword;
  final int minLines;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.hint,
    this.hintColor = AppColors.white,
    this.backgroundColor = AppColors.darkGrey,
    this.prefixIcon,
    this.prefixIconColor = AppColors.white,
    this.prefixIconSize = 30,
    this.isPassword = false,
    this.controller,
    this.minLines = 1,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.backgroundColor,
        prefixIcon: widget.prefixIcon == null
            ? null
            : Container(
                margin: EdgeInsets.symmetric(horizontal: 12),
                child: widget.prefixIcon
              ),
        suffixIcon: widget.isPassword
            ? InkWell(
                onTap: () {
                  obscureText = !obscureText;
                  setState(() {});
                },
                child: Icon(
                  obscureText ? Icons.visibility_off : Icons.remove_red_eye,
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        hintText: widget.hint,
      ),
      minLines: widget.minLines,
      maxLines: widget.isPassword ? 1 : widget.minLines + 1,
      obscureText: widget.isPassword ? obscureText : false,
    );
  }
}
