
import 'package:movies_app/core/utils/constants/imports.dart';

import '../../../../../l10n/app_localizations.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  int selectedAvatarId = 1;

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
    context.read<ProfileCubit>().getProfile();
  }

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
              final isSelected = (index + 1) == selectedAvatarId;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAvatarId = index + 1;
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.yellow : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
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
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.editProfile),
        leading: IconButton(
          onPressed: () => Navigator.pop(context, false),
          icon: Icon(Icons.arrow_back, color: AppColors.yellow),
        ),
      ),
      body: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {
          if (state is ProfileUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text(loc.profileUpdatedSuccessfully)),
            );
            Navigator.pop(context, true);
          } else if (state is ProfileDeleted) {
            Navigator.push(context, AppRoutes.login);
          } else if (state is ProfileError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(
                content: Text("${loc.error}: ${state.message}")));
          } else if (state is ProfileLoaded) {
            nameController.text = state.user.name;
            phoneController.text = state.user.phone;
            selectedAvatarId = state.user.avaterId;
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.yellow),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: GestureDetector(
                    onTap: _showAvatarPicker,
                    child: CircleAvatar(
                      radius: context.width * 0.15,
                      backgroundImage: AssetImage(
                        avatars[selectedAvatarId - 1],
                      ),
                    ),
                  ),
                ),
              ),
              CustomTextField(
                hint: loc.name,
                controller: nameController,
                prefixIcon: Icon(Icons.person, color: AppColors.white),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                hint: loc.phone,
                controller: phoneController,
                prefixIcon: Icon(Icons.phone, color: AppColors.white),
              ),
              const Spacer(),
              CustomButton(
                text: loc.deleteAccount,
                onClick: () => context.read<ProfileCubit>().deleteProfile(),
                backgroundColor: AppColors.red,
                textColor: AppColors.white,
                borderColor: AppColors.red,
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: loc.updateData,
                onClick: () => context.read<ProfileCubit>().updateProfile(
                  name: nameController.text,
                  avatar: selectedAvatarId,
                ),
              ),
              const SizedBox(height: 40),
            ],
          );
        },
      ),
    );
  }
}
