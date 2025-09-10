import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/core/theme/app_text_styles.dart';
import 'package:movies_app/core/utils/constants/app_assets.dart';
import 'package:movies_app/core/utils/constants/app_routes.dart';
import 'package:movies_app/ui/screens/home/tabs/profile_tab/cubit/profile_cubit.dart';
import 'package:movies_app/ui/screens/home/tabs/profile_tab/widgets/history_list.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History", style: AppTextStyles.yelowBold20),
        actions: [
          IconButton(
            icon: Image.asset(AppAssets.icExit, color: AppColors.yellow),
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
      body: HistoryList(),
    );
  }
}
