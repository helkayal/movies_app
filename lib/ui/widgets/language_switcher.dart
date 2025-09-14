import 'package:flutter/material.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/core/utils/constants/app_assets.dart';
import 'package:movies_app/ui/screens/auth/local_provider/local_provider.dart';
import 'package:provider/provider.dart';

class LanguageSwitcher extends StatefulWidget {
  final double heightRatio;
  final double widthRatio;
  const LanguageSwitcher({
    super.key,
    this.heightRatio = 0.05,
    this.widthRatio = 0.25,
  });

  @override
  State<LanguageSwitcher> createState() => _LanguageSwitcherState();
}

class _LanguageSwitcherState extends State<LanguageSwitcher> {
  bool isArabic = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final localeProvider = Provider.of<LocaleProvider>(context); // ✅ Provider

    // تحديث الزر حسب اللغة الحالية
    isArabic = localeProvider.locale.languageCode == 'ar';

    return GestureDetector(
      onTap: () {
        final newLocale = isArabic ? const Locale('en') : const Locale('ar');
        localeProvider.setLocale(newLocale);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: width * widget.widthRatio,
        height: height * widget.heightRatio,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: AppColors.transperant,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.yellow, width: 2),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Image.asset(AppAssets.icAr),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(AppAssets.icEn),
            ),
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              alignment: isArabic
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.yellow, width: 4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
