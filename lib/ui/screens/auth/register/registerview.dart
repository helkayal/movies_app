import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/constants/app_routes.dart';
import 'package:movies_app/ui/widgets/custom_text_field.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/constants/app_assets.dart';
import '../authbloc/authbloc.dart';
import '../authbloc/authevent.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  int selectedIndex = 0;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // 👇 Avatar list
  final List<Map<String, dynamic>> avaters = [
    {'id': 1, 'image': AppAssets.avatar1},
    {'id': 2, 'image': AppAssets.avatar2},
    {'id': 3, 'image': AppAssets.avatar3},
    {'id': 4, 'image': AppAssets.avatar4},
    {'id': 5, 'image': AppAssets.avatar5},
    {'id': 6, 'image': AppAssets.avatar6},
    {'id': 7, 'image': AppAssets.avatar7},
    {'id': 8, 'image': AppAssets.avatar8},
    {'id': 9, 'image': AppAssets.avatar9},
  ];

  int get selectedavaterId => avaters[selectedIndex]['id'];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Navigator.pushReplacement(context, AppRoutes.login),
          icon: Icon(Icons.arrow_back, color: AppColors.yellow),
        ),
        centerTitle: true,
        title: const Text('Register', style: AppTextStyles.yelowRegular14),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: height * 0.09),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: avaters.length,
                  itemBuilder: (context, index) {
                    bool isSelected = selectedIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: isSelected ? 10 : 30,
                        ),
                        width: isSelected ? 150 : 100,
                        height: isSelected ? 150 : 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(avaters[index]["image"]!),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 10,
                                    offset: Offset(0, 5),
                                  ),
                                ]
                              : [],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              const Text('Avatar', style: AppTextStyles.whiteRegular16),
              SizedBox(height: height * 0.015),
              _buildTextField(
                width,
                "Name",
                AppAssets.name,
                nameController,
                false,
              ),
              SizedBox(height: height * 0.015),
              _buildTextField(
                width,
                "Email",
                AppAssets.email,
                emailController,
                false,
              ),
              SizedBox(height: height * 0.015),
              _buildTextField(
                width,
                "Password",
                AppAssets.lock,
                passwordController,
                true,
              ),
              SizedBox(height: height * 0.015),
              _buildTextField(
                width,
                "Confirm Password",
                AppAssets.lock,
                confirmPasswordController,
                true,
              ),
              SizedBox(height: height * 0.015),
              _buildTextField(
                width,
                "Phone Number",
                AppAssets.call,
                phoneController,
                false,
              ),
              SizedBox(height: height * 0.015),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (passwordController.text !=
                        confirmPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Passwords do not match")),
                      );
                      return;
                    }
                    context.read<AuthBloc>().add(
                      RegisterRequested(
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        confirmPassword: confirmPasswordController.text,
                        phone: phoneController.text,
                        avaterId: selectedavaterId,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.yellow,
                  minimumSize: Size(width * 0.9, height * 0.07),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Create Account',
                  style: AppTextStyles.blackRegular20,
                ),
              ),
              SizedBox(height: height * 0.02),
              const LanguageSwitcher(),
              SizedBox(height: height * 0.099),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    double width,
    String hint,
    String icon,
    TextEditingController controller,
    bool isPassword,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
      child: CustomTextField(
        hint: hint,
        prefixIcon: Image.asset(icon),
        controller: controller,
        isPassword: isPassword,
      ),
    );
  }
}

class LanguageSwitcher extends StatefulWidget {
  const LanguageSwitcher({super.key});
  @override
  State<LanguageSwitcher> createState() => _LanguageSwitcherState();
}

class _LanguageSwitcherState extends State<LanguageSwitcher> {
  bool isArabic = true;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => setState(() => isArabic = !isArabic),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: width * 0.26,
        height: height * 0.05,
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
              child: Image.asset(AppAssets.eg),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(AppAssets.us),
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
