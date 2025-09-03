import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/ui/screens/home/tabs/profile_tab/cubit/profile_cubit.dart';
import 'package:movies_app/ui/screens/home/tabs/profile_tab/cubit/profile_states.dart';
import 'package:movies_app/ui/utils/app_assets.dart';
import 'package:movies_app/ui/utils/app_colors.dart';
import 'package:movies_app/ui/utils/app_routes.dart';
import 'package:movies_app/ui/utils/app_text_styles.dart';
import 'package:movies_app/ui/utils/context_extension.dart';
import 'package:movies_app/ui/widgets/custom_button.dart';
import 'package:movies_app/ui/widgets/custom_gride_view.dart';
import 'package:movies_app/model/movie_dm.dart';

class ProfileTab extends StatefulWidget {
  final List<Movies> movie;
  const ProfileTab({super.key, required this.movie});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> avatars = [
      AppAssets.avatar1,
      AppAssets.avatar2,
      AppAssets.avatar3,
      AppAssets.avatar4,
      AppAssets.avatar5,
      AppAssets.avatar6,
      AppAssets.avatar7,
      AppAssets.avatar8,
      AppAssets.avatar9,
    ];

    return BlocBuilder<ProfileCubit, ProfileStates>(
      builder: (context, state) {
        String userName = "Guest";
        String avatarPath = avatars[0];

        if (state is ProfileLoaded) {
          userName = state.user.name;
          avatarPath = avatars[state.user.avaterId - 1];
        }

        return DefaultTabController(
          length: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: AppColors.darkGrey,
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      spacing: 15,
                      children: [
                        Image.asset(
                          avatarPath,
                          width: context.width * 0.25,
                          fit: BoxFit.contain,
                        ),
                        Text(userName, style: AppTextStyles.whiteBold20),
                      ],
                    ),
                    Column(
                      spacing: 10,
                      children: [
                        Text('12', style: AppTextStyles.whiteBold36),
                        Text('Wish List', style: AppTextStyles.whiteBold24),
                      ],
                    ),
                    Column(
                      spacing: 10,
                      children: [
                        Text('10', style: AppTextStyles.whiteBold36),
                        Text('History', style: AppTextStyles.whiteBold24),
                      ],
                    ),
                  ],
                ),
              ),

              // Buttons
              Container(
                color: AppColors.darkGrey,
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: context.width * 0.62,
                      child: CustomButton(
                        text: 'Edit Profile',
                        onClick: () {
                          Navigator.push(context, AppRoutes.editProfile).then((
                            updated,
                          ) {
                            if (updated == true && context.mounted) {
                              context.read<ProfileCubit>().getProfile();
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: context.width * 0.32,
                      child: CustomButton(
                        text: 'Exit',
                        onClick: () async {
                          context.read<ProfileCubit>().deleteProfile();
                          if (!context.mounted) return;
                          Navigator.pushAndRemoveUntil(
                            context,
                            AppRoutes.login,
                            (route) => false,
                          );
                        },
                        icon: Image.asset(AppAssets.icExit),
                        backgroundColor: AppColors.red,
                        borderColor: AppColors.red,
                        textColor: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // Tab bar
              Container(
                color: AppColors.darkGrey,
                child: TabBar(
                  indicatorColor: AppColors.yellow,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 3,
                  labelColor: AppColors.white,
                  unselectedLabelColor: AppColors.darkGrey,
                  tabs: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(AppAssets.icWishList, height: 30),
                        const SizedBox(height: 4),
                        Text("Wish List", style: AppTextStyles.whiteRegular20),
                        SizedBox(height: 10),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(AppAssets.icHistory, height: 30),
                        const SizedBox(height: 4),
                        Text("History", style: AppTextStyles.whiteRegular20),
                        SizedBox(height: 10),
                      ],
                    ),
                  ],
                ),
              ),

              // Tab views
              Expanded(
                child: TabBarView(
                  children: [
                    Center(child: Image.asset(AppAssets.emptyList, width: 150)),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      child: CustomGrideView(
                        rowItemCount: 3,
                        movie: widget.movie,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
