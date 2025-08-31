import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/uitlies/Appcolor.dart';

class AppStyle{
  static TextStyle blackfont20= GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColor.blackFontColor,
  );
  static TextStyle blackfont16= GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColor.blackFontColor,
  );
  static TextStyle whitefont16= GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColor.whiteColor,
  );
  static TextStyle yellowfont16= GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColor.yellowColor,
  );
  static TextStyle yellow14font= GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColor.yellowColor,
  );
}