import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

abstract final class AppTextStyles {
  // yellow text styles
  static final yelowRegular14 = TextStyle(
    fontSize: 14.sp,
    color: AppColors.yellow,
    fontWeight: FontWeight.w400,
  );
  static final yelowBlack14 = TextStyle(
    fontSize: 14.sp,
    color: AppColors.yellow,
    fontWeight: FontWeight.w900,
  );
  static final yelowRegular15 = TextStyle(
    fontSize: 15.sp,
    color: AppColors.yellow,
    fontWeight: FontWeight.w400,
  );
  static final yelowRegular16 = TextStyle(
    fontSize: 16.sp,
    color: AppColors.yellow,
    fontWeight: FontWeight.w400,
  );
  static final yelowBold20 = TextStyle(
    fontSize: 20.sp,
    color: AppColors.yellow,
    fontWeight: FontWeight.w700,
  );

  // white text styles
  static final whiteRegular14 = TextStyle(
    fontSize: 14.sp,
    color: AppColors.white,
    fontWeight: FontWeight.w400,
  );
  static final whiteRegular16 = TextStyle(
    fontSize: 16.sp,
    color: AppColors.white,
    fontWeight: FontWeight.w400,
  );
  static final whiteRegular20 = TextStyle(
    fontSize: 20.sp,
    color: AppColors.white,
    fontWeight: FontWeight.w400,
  );
  static final whiteBold20 = TextStyle(
    fontSize: 20.sp,
    color: AppColors.white,
    fontWeight: FontWeight.w700,
  );

  static final whiteBold24 = TextStyle(
    fontSize: 24.sp,
    color: AppColors.white,
    fontWeight: FontWeight.w700,
  );

  static final whiteMediumd36 = TextStyle(
    fontSize: 36.sp,
    color: AppColors.white,
    fontWeight: FontWeight.w500,
  );
  static final whiteBold36 = TextStyle(
    fontSize: 36.sp,
    color: AppColors.white,
    fontWeight: FontWeight.w700,
  );

  // light grey text styles
  static final lightGreyRegular20 = TextStyle(
    fontSize: 20.sp,
    color: AppColors.lightGrey,
    fontWeight: FontWeight.w400,
  );

  static final lightGreyBold20 = TextStyle(
    fontSize: 20.sp,
    color: AppColors.lightGrey,
    fontWeight: FontWeight.w700,
  );

  // dark grey text styles
  static final darkGreyRegular20 = TextStyle(
    fontSize: 20.sp,
    color: AppColors.darkGrey,
    fontWeight: FontWeight.w400,
  );

  // black text styles
  static final blackRegular20 = TextStyle(
    fontSize: 20.sp,
    color: AppColors.black,
    fontWeight: FontWeight.w400,
  );
  static final blackSemiBold20 = TextStyle(
    fontSize: 20.sp,
    color: AppColors.black,
    fontWeight: FontWeight.w600,
  );
  static final blackBold20 = TextStyle(
    fontSize: 20.sp,
    color: AppColors.black,
    fontWeight: FontWeight.w700,
  );
}
