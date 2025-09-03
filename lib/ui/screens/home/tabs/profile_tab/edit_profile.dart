// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:movies_app/ui/utils/app_assets.dart';
// import 'package:movies_app/ui/utils/app_colors.dart';
// import 'package:movies_app/ui/utils/app_routes.dart';
// import 'package:movies_app/ui/utils/app_text_styles.dart';
// import 'package:movies_app/ui/utils/context_extension.dart';
// import 'package:movies_app/ui/widgets/custom_button.dart';
// import 'package:movies_app/ui/widgets/custom_text_field.dart';

// class EditProfile extends StatelessWidget {
//   const EditProfile({super.key});

//   @override
//   Widget build(BuildContext context) {
//     TextEditingController nameController = TextEditingController();
//     TextEditingController phoneController = TextEditingController();
//     nameController.text = 'John Safwat';
//     phoneController.text = '01200000000';

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Pick Avatar'),
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: Icon(Icons.arrow_back, color: AppColors.yellow),
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 40),
//               child: Image.asset(
//                 AppAssets.avatar8,
//                 width: context.width * 0.3,
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ),
//           CustomTextField(
//             hint: '',
//             controller: nameController,
//             prefixIcon: Icon(Icons.person, color: AppColors.white),
//           ),
//           SizedBox(height: 20),
//           CustomTextField(
//             hint: '',
//             controller: phoneController,
//             prefixIcon: Icon(Icons.phone, color: AppColors.white),
//           ),
//           SizedBox(height: 20),
//           TextButton(
//             onPressed: () {
//               Navigator.push(context, AppRoutes.forgetPassword);
//             },
//             child: Text('Reset Password', style: AppTextStyles.whiteRegular20),
//           ),
//           Spacer(),
//           CustomButton(
//             text: 'Delete Account',
//             onClick: () {},
//             backgroundColor: AppColors.red,
//             textColor: AppColors.white,
//             borderColor: AppColors.red,
//           ),
//           SizedBox(height: 20),
//           CustomButton(text: 'Update Data', onClick: () {}),
//           SizedBox(height: 40),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../../../../../core/utils/constants/app_assets.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/constants/app_routes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/utils/context_extension.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_field.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  String selectedAvatar = AppAssets.avatar8;

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

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: 'John Safwat');
    phoneController = TextEditingController(text: '01200000000');
  }

  // void _showAvatarPicker() {
  //   showModalBottomSheet(
  //     context: context,
  //     backgroundColor: AppColors.darkGrey,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     builder: (context) {
  //       return Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: GridView.builder(
  //           shrinkWrap: true,
  //           itemCount: avatars.length,
  //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //             crossAxisCount: 3,
  //             crossAxisSpacing: 16,
  //             mainAxisSpacing: 16,
  //           ),
  //           itemBuilder: (context, index) {
  //             final avatar = avatars[index];
  //             return GestureDetector(
  //               onTap: () {
  //                 setState(() {
  //                   selectedAvatar = avatar;
  //                 });
  //                 Navigator.pop(context);
  //               },
  //               child: CircleAvatar(
  //                 radius: 40,
  //                 backgroundColor: AppColors.yellow,
  //                 child: CircleAvatar(
  //                   radius: 38,
  //                   backgroundImage: AssetImage(avatar),
  //                 ),
  //               ),
  //             );
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }

  void _showAvatarPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.darkGrey,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: avatars.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              final avatar = avatars[index];
              final isSelected = avatar == selectedAvatar;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAvatar = avatar;
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.yellow : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.yellow, width: 2),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(avatar, fit: BoxFit.contain),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Avatar'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: AppColors.yellow),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: GestureDetector(
                onTap: _showAvatarPicker,
                child: CircleAvatar(
                  radius: context.width * 0.15,
                  backgroundImage: AssetImage(selectedAvatar),
                ),
              ),
            ),
          ),
          CustomTextField(
            hint: '',
            controller: nameController,
            prefixIcon: Icon(Icons.person, color: AppColors.white),
          ),
          SizedBox(height: 20),
          CustomTextField(
            hint: '',
            controller: phoneController,
            prefixIcon: Icon(Icons.phone, color: AppColors.white),
          ),
          SizedBox(height: 20),
          TextButton(
            onPressed: () {
              Navigator.push(context, AppRoutes.forgetPassword);
            },
            child: Text('Reset Password', style: AppTextStyles.whiteRegular20),
          ),
          Spacer(),
          CustomButton(
            text: 'Delete Account',
            onClick: () {},
            backgroundColor: AppColors.red,
            textColor: AppColors.white,
            borderColor: AppColors.red,
          ),
          SizedBox(height: 20),
          CustomButton(text: 'Update Data', onClick: () {}),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
