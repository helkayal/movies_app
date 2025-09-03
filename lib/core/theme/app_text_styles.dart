import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract final class AppTextStyles {
  // yellow text styles
  static const yelowRegular14 = TextStyle(
    fontSize: 14,
    color: AppColors.yellow,
    fontWeight: FontWeight.w400,
  );
  static const yelowBlack14 = TextStyle(
    fontSize: 14,
    color: AppColors.yellow,
    fontWeight: FontWeight.w900,
  );
  static const yelowRegular15 = TextStyle(
    fontSize: 15,
    color: AppColors.yellow,
    fontWeight: FontWeight.w400,
  );
  static const yelowRegular16 = TextStyle(
    fontSize: 16,
    color: AppColors.yellow,
    fontWeight: FontWeight.w400,
  );
  static const yelowBold20 = TextStyle(
    fontSize: 20,
    color: AppColors.yellow,
    fontWeight: FontWeight.w700,
  );

  // white text styles
  static const whiteRegular16 = TextStyle(
    fontSize: 16,
    color: AppColors.white,
    fontWeight: FontWeight.w400,
  );
  static const whiteRegular20 = TextStyle(
    fontSize: 20,
    color: AppColors.white,
    fontWeight: FontWeight.w400,
  );
  static const whiteBold20 = TextStyle(
    fontSize: 20,
    color: AppColors.white,
    fontWeight: FontWeight.w700,
  );

  static const whiteBold24 = TextStyle(
    fontSize: 24,
    color: AppColors.white,
    fontWeight: FontWeight.w700,
  );

  static const whiteMediumd36 = TextStyle(
    fontSize: 36,
    color: AppColors.white,
    fontWeight: FontWeight.w500,
  );
  static const whiteBold36 = TextStyle(
    fontSize: 36,
    color: AppColors.white,
    fontWeight: FontWeight.w700,
  );

  // light grey text styles
  static final lightGreyRegular20 = TextStyle(
    fontSize: 20,
    color: AppColors.lightGrey,
    fontWeight: FontWeight.w400,
  );

  static final lightGreyBold20 = TextStyle(
    fontSize: 20,
    color: AppColors.lightGrey,
    fontWeight: FontWeight.w700,
  );

  // dark grey text styles
  static const darkGreyRegular20 = TextStyle(
    fontSize: 20,
    color: AppColors.darkGrey,
    fontWeight: FontWeight.w400,
  );

  // black text styles
  static const blackRegular20 = TextStyle(
    fontSize: 20,
    color: AppColors.black,
    fontWeight: FontWeight.w400,
  );
  static const blackSemiBold20 = TextStyle(
    fontSize: 20,
    color: AppColors.black,
    fontWeight: FontWeight.w600,
  );
  static const blackBold20 = TextStyle(
    fontSize: 20,
    color: AppColors.black,
    fontWeight: FontWeight.w700,
  );
}
