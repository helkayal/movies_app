// import 'package:flutter/material.dart';
// import 'package:movies_app/ui/utils/app_assets.dart';
// import 'package:movies_app/ui/utils/app_colors.dart';
// import 'package:movies_app/ui/utils/app_text_styles.dart';
// import 'package:movies_app/ui/utils/context_extension.dart';
// import 'package:movies_app/ui/widgets/custom_button.dart';

// class ProfileTab extends StatelessWidget {
//   const ProfileTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Container(
//           color: AppColors.darkGrey,
//           padding: const EdgeInsets.symmetric(vertical: 20),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Column(
//                 spacing: 15,
//                 children: [
//                   Image.asset(
//                     AppAssets.avatar1,
//                     width: context.width * 0.25,
//                     fit: BoxFit.contain,
//                   ),
//                   Text('John Safwat', style: AppTextStyles.whiteBold20),
//                 ],
//               ),
//               Column(
//                 spacing: 20,
//                 children: [
//                   Text('12', style: AppTextStyles.whiteBold36),
//                   Text('Wish List', style: AppTextStyles.whiteBold24),
//                 ],
//               ),
//               Column(
//                 spacing: 20,
//                 children: [
//                   Text('10', style: AppTextStyles.whiteBold36),
//                   Text('History', style: AppTextStyles.whiteBold24),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         Container(
//           color: AppColors.darkGrey,
//           padding: const EdgeInsets.only(bottom: 20),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               SizedBox(
//                 width: context.width * 0.62,
//                 child: CustomButton(text: 'Edit Profile', onClick: () {}),
//               ),
//               SizedBox(
//                 width: context.width * 0.32,
//                 child: CustomButton(
//                   text: 'Exit',
//                   onClick: () {},
//                   icon: Image.asset(AppAssets.icExit),
//                   backgroundColor: AppColors.red,
//                   borderColor: AppColors.red,
//                   textColor: AppColors.white,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Row(children: [Text('Profile Tab', style: AppTextStyles.whiteBold24)]),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../../../../core/utils/constants/app_assets.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/constants/app_routes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/utils/context_extension.dart';
import '../../../../../data/model/movie_dm.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_gride_view.dart';

class ProfileTab extends StatelessWidget {
  final List<Movies> movie;
  const ProfileTab({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
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
                      AppAssets.avatar8,
                      width: context.width * 0.25,
                      fit: BoxFit.contain,
                    ),
                    Text('John Safwat', style: AppTextStyles.whiteBold20),
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
                      Navigator.push(context, AppRoutes.editProfile);
                    },
                  ),
                ),
                SizedBox(
                  width: context.width * 0.32,
                  child: CustomButton(
                    text: 'Exit',
                    onClick: () {},
                    icon: Image.asset(AppAssets.icExit),
                    backgroundColor: AppColors.red,
                    borderColor: AppColors.red,
                    textColor: AppColors.white,
                  ),
                ),
              ],
            ),
          ),

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
                    movie: movie,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
