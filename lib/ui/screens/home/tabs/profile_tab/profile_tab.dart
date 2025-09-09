import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/core/utils/constants/imports.dart';
import 'package:movies_app/data/model/movie_details_model.dart';
import 'package:movies_app/ui/screens/home/tabs/profile_tab/cubit/history_cubit.dart';
import 'package:movies_app/ui/screens/home/tabs/profile_tab/widgets/history_list.dart';

import '../../../../../l10n/app_localizations.dart';

class ProfileTab extends StatefulWidget {
  final List<Movie> movie;
  const ProfileTab({super.key, required this.movie});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final User? firebaseUser = FirebaseAuth.instance.currentUser; // ✅ يجيب بيانات جوجل

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getProfile();
    context.read<FavouriteCubit>().loadFavourites();
    context.read<HistoryCubit>().loadHistory();
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
    final loc = AppLocalizations.of(context)!;

    return BlocBuilder<ProfileCubit, ProfileStates>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.yellow),
          );
        }

        String userName = loc.guest;
        String avatarPath = avatars[0];

        // ✅ لو اليوزر من Firebase (جوجل)
        if (firebaseUser != null) {
          userName = firebaseUser?.displayName ?? "Guest"; // ✅ String
          avatarPath = firebaseUser?.photoURL ?? avatars[0]; // صورة جوجل
        }


        // ✅ لو اليوزر من API
        if (state is ProfileLoaded) {
          userName = state.user.name;
          avatarPath = avatars[state.user.avaterId - 1];
        }

        if (state is ProfileError) {
          return Center(
            child: Text(
              "${loc.error}: ${state.message}",
              style: AppTextStyles.whiteBold20,
            ),
          );
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
                        firebaseUser?.photoURL != null
                            ? CircleAvatar(
                          radius: context.width * 0.12,
                          backgroundImage:
                          NetworkImage(firebaseUser!.photoURL!),
                        )
                            : Image.asset(
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
                        Text("12", style: AppTextStyles.whiteBold36),
                        Text(loc.wishList, style: AppTextStyles.whiteBold24),
                      ],
                    ),
                    Column(
                      spacing: 10,
                      children: [
                        Text("10", style: AppTextStyles.whiteBold36),
                        Text(loc.history, style: AppTextStyles.whiteBold24),
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
                        text: loc.editProfile,
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
                        text: loc.exit,
                        onClick: () async {
                          // ✅ لو جوجل اعمل signOut من Firebase
                          if (firebaseUser != null) {
                            await FirebaseAuth.instance.signOut();
                          }
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

              // Tabs
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
                        Text(loc.wishList, style: AppTextStyles.whiteRegular20),
                        SizedBox(height: 10),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(AppAssets.icHistory, height: 30),
                        const SizedBox(height: 4),
                        Text(loc.history, style: AppTextStyles.whiteRegular20),
                        SizedBox(height: 10),
                      ],
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TabBarView(
                    children: [const FavouriteList(), HistoryList()],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
