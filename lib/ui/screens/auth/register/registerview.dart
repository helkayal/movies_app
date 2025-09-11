import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/constants/app_routes.dart';
import 'package:movies_app/ui/widgets/custom_text_field.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/constants/app_assets.dart';
import '../../../../l10n/app_localizations.dart';
import '../authbloc/authbloc.dart';
import '../authbloc/authevent.dart';

class RegisterView extends StatefulWidget {
  final bool isLoading;
  final void Function(Locale) onLocaleChange;

  const RegisterView({
    super.key,
    this.isLoading = false,
    required this.onLocaleChange,
  });

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  int selectedIndex = 0;
  bool isArabic = false; // يبدأ بالإنجليزي
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<Map<String, dynamic>> avatars = [
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

  int get selectedAvatarId => avatars[selectedIndex]['id'];

  @override
  Widget build(BuildContext context) {
    return Localizations.override(
      context: context,
      locale: isArabic ? const Locale('ar') : const Locale('en'),
      child: Builder(
        builder: (context) {
          final loc = AppLocalizations.of(context)!;
          final height = MediaQuery.of(context).size.height;
          final width = MediaQuery.of(context).size.width;

          return Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.black,
              leading: IconButton(
                onPressed: () =>
                    Navigator.pushReplacement(context, AppRoutes.login),
                icon: Icon(Icons.arrow_back, color: AppColors.yellow),
              ),
              centerTitle: true,
              title: Text(loc.register, style: AppTextStyles.yelowRegular14),
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
                        itemCount: avatars.length,
                        itemBuilder: (context, index) {
                          final isSelected = selectedIndex == index;
                          return GestureDetector(
                            onTap: () => setState(() => selectedIndex = index),
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
                                  image: AssetImage(avatars[index]["image"]!),
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
                    SizedBox(height: 10),
                    Text(loc.avatar, style: AppTextStyles.whiteRegular16),
                    SizedBox(height: height * 0.015),
                    _buildTextField(
                      width,
                      loc.name,
                      AppAssets.name,
                      nameController,
                      false,
                    ),
                    SizedBox(height: height * 0.015),
                    _buildTextField(
                      width,
                      loc.email,
                      AppAssets.email,
                      emailController,
                      false,
                    ),
                    SizedBox(height: height * 0.015),
                    _buildTextField(
                      width,
                      loc.password,
                      AppAssets.lock,
                      passwordController,
                      true,
                    ),
                    SizedBox(height: height * 0.015),
                    _buildTextField(
                      width,
                      loc.confirmPassword,
                      AppAssets.lock,
                      confirmPasswordController,
                      true,
                    ),
                    SizedBox(height: height * 0.015),
                    _buildTextField(
                      width,
                      loc.phoneNumber,
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
                              SnackBar(content: Text(loc.passwordsDoNotMatch)),
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
                              avaterId: selectedAvatarId,
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
                      child: Text(
                        loc.createAccount,
                        style: AppTextStyles.blackRegular20,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    // Language Switcher يبدأ بالإنجليزي
                    LanguageSwitcher(
                      isArabic: isArabic,
                      onChanged: (val) {
                        setState(() {
                          isArabic = val;
                        });
                      },
                    ),
                    SizedBox(height: height * 0.099),
                  ],
                ),
              ),
            ),
          );
        },
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

class LanguageSwitcher extends StatelessWidget {
  final bool isArabic;
  final ValueChanged<bool> onChanged;

  const LanguageSwitcher({
    super.key,
    required this.isArabic,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => onChanged(!isArabic),
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
            // العلم العربي على اليمين
            Align(
              alignment: Alignment.centerRight,
              child: Image.asset(AppAssets.icAr),
            ),
            // العلم الإنجليزي على الشمال
            Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(AppAssets.icEn),
            ),
            // الدائرة المتحركة
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              alignment: isArabic
                  ? Alignment
                        .centerRight // العربي على اليمين
                  : Alignment.centerLeft, // الإنجليزي على الشمال
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
