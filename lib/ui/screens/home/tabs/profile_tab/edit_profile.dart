import 'package:movies_app/core/utils/constants/imports.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context, false),
          icon: Icon(Icons.arrow_back, color: AppColors.yellow),
        ),
      ),
      body: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {
          if (state is ProfileUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Profile updated successfully")),
            );
            Navigator.pop(context, true);
          } else if (state is ProfileDeleted) {
            Navigator.push(context, AppRoutes.login);
          } else if (state is ProfileError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Error: ${state.message}")));
          } else if (state is ProfileLoaded) {
            nameController.text = state.user.name;
            emailController.text = state.user.email;
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
                hint: 'Name',
                controller: nameController,
                prefixIcon: Image.asset(AppAssets.name),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hint: 'Email',
                controller: emailController,
                prefixIcon: Image.asset(AppAssets.email),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                hint: 'Phone',
                controller: phoneController,
                prefixIcon: Image.asset(AppAssets.call),
              ),
              const Spacer(),
              CustomButton(
                text: 'Delete Account',
                onClick: () => context.read<ProfileCubit>().deleteProfile(),
                backgroundColor: AppColors.red,
                textColor: AppColors.white,
                borderColor: AppColors.red,
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Update Data',
                onClick: () => context.read<ProfileCubit>().updateProfile(
                  name: nameController.text,
                  email: emailController.text,
                  avatar: selectedAvatarId,
                  phone: phoneController.text,
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
