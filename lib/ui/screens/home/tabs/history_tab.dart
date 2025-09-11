import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/core/theme/app_text_styles.dart';
import 'package:movies_app/core/utils/constants/app_assets.dart';
import 'package:movies_app/core/utils/constants/app_routes.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/ui/screens/home/tabs/profile_tab/cubit/profile_cubit.dart';
import 'package:movies_app/ui/screens/home/tabs/profile_tab/widgets/history_list.dart';
import 'package:movies_app/ui/widgets/language_switcher.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LanguageSwitcher(),
            Text(loc.history, style: AppTextStyles.yelowBold20),
            IconButton(
              icon: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..scale(
                    Directionality.of(context) == TextDirection.rtl
                        ? -1.0
                        : 1.0,
                    1.0,
                  ),
                child: Image.asset(AppAssets.icExit, color: AppColors.yellow),
              ),
              onPressed: () async {
                context.read<ProfileCubit>().logOut();
                if (!context.mounted) return;
                Navigator.pushAndRemoveUntil(
                  context,
                  AppRoutes.login,
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: HistoryList(),
    );
  }
}
