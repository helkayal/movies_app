import 'package:movies_app/core/utils/constants/imports.dart';
import 'package:movies_app/core/utils/secure_storage_utils.dart';
import 'package:movies_app/ui/screens/home/tabs/profile_tab/cubit/history_cubit.dart';
import 'package:movies_app/ui/screens/home/tabs/profile_tab/cubit/history_states.dart';
import 'package:movies_app/ui/screens/home/tabs/profile_tab/widgets/history_list.dart';

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

    return BlocBuilder<ProfileCubit, ProfileStates>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.yellow),
          );
        }

        String userName = "Guest";
        String avatarPath = avatars[0];

        if (state is ProfileLoaded) {
          userName = state.user.name;
          avatarPath = avatars[state.user.avaterId - 1];
        }

        if (state is ProfileError) {
          return Center(
            child: Text(
              "Error: ${state.message}",
              style: AppTextStyles.whiteBold20,
            ),
          );
        }

        return DefaultTabController(
          length: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Container(
                color: AppColors.darkGrey,
                padding: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Avatar + Username
                    Expanded(
                      flex: 3,
                      child: Column(
                        spacing: 15,
                        children: [
                          Image.asset(
                            avatarPath,
                            width: context.width * 0.25,
                            fit: BoxFit.contain,
                          ),
                          Text(
                            userName,
                            style: AppTextStyles.whiteBold20,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),

                    // Wish List count
                    Expanded(
                      flex: 2,
                      child: Column(
                        spacing: 10,
                        children: [
                          BlocBuilder<FavouriteCubit, FavouriteStates>(
                            builder: (context, favState) {
                              int favCount = 0;
                              if (favState is FavouriteLoaded) {
                                favCount = favState.favourites.length;
                              }
                              return Text(
                                '$favCount',
                                style: AppTextStyles.whiteBold24,
                              );
                            },
                          ),
                          Text('Wish List', style: AppTextStyles.whiteBold20),
                        ],
                      ),
                    ),

                    // History count
                    Expanded(
                      flex: 2,
                      child: Column(
                        spacing: 10,
                        children: [
                          BlocBuilder<HistoryCubit, HistoryStates>(
                            builder: (context, historyState) {
                              int historyCount = 0;
                              if (historyState is HistoryLoaded) {
                                historyCount = historyState.movies.length;
                              }
                              return Text(
                                '$historyCount',
                                style: AppTextStyles.whiteBold24,
                              );
                            },
                          ),
                          Text('History', style: AppTextStyles.whiteBold20),
                        ],
                      ),
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
                          await SecureStorageUtils().logout();
                          if (!context.mounted) return;
                          Navigator.pushReplacement(context, AppRoutes.login);
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
