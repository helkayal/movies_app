import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart'; // ✅ استدعاء Provider
import '../../../../data/datasources/google/google_auth.dart';
import '../../../../l10n/app_localizations.dart';
import '../authbloc/authbloc.dart';
import '../authbloc/authevent.dart';
import '../authbloc/authstate.dart';
import '../../../../core/utils/constants/imports.dart';
import '../local_provider/local_provider.dart'; // ✅ Provider

class LoginView extends StatefulWidget {
  final bool isLoading;
  final GoogleAuth googleAuth = GoogleAuth();

   LoginView({super.key, this.isLoading = false});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: height * 0.1),
            Image.asset(AppAssets.videologo),
            SizedBox(height: height * 0.09),

            // Email
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: SizedBox(
                width: width * 0.95,
                child: CustomTextField(
                  hint: loc.email,
                  controller: emailController,
                  prefixIcon: Image.asset(AppAssets.email),
                ),
              ),
            ),
            SizedBox(height: height * 0.01),

            // Password
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03),
              child: SizedBox(
                width: width * 0.95,
                child: CustomTextField(
                  hint: loc.password,
                  controller: passwordController,
                  prefixIcon: Image.asset(AppAssets.lock),
                  isPassword: true,
                ),
              ),
            ),
            SizedBox(height: height * 0.02),

            // Forget Password
            Padding(
              padding: EdgeInsets.only(right: width * 0.05),
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      AppRoutes.forgetPassword,
                    );
                  },
                  child: Text(
                    loc.forgotPassword,
                    style: AppTextStyles.yelowRegular14,
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.03),

            // Login Button (Bloc)
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                bool isLoading = state is AuthLoading || widget.isLoading;
                return Column(
                  children: [
                    ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                        context.read<AuthBloc>().add(
                          LoginRequested(
                            emailController.text,
                            passwordController.text,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.yellow,
                        minimumSize: Size(width * 0.9, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(loc.login, style: AppTextStyles.blackRegular20),
                    ),
                    SizedBox(height: height * 0.03),

                    // Create Account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(loc.dontHaveAccount, style: AppTextStyles.whiteRegular14),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(context, AppRoutes.register);
                          },
                          child: Text(loc.createOne, style: AppTextStyles.yelowBlack14),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.02),

                    // OR Divider
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColors.yellow,
                            thickness: 1,
                            indent: width * 0.05,
                            endIndent: 10,
                          ),
                        ),
                        Text(loc.or, style: TextStyle(color: AppColors.yellow, fontSize: 14)),
                        Expanded(
                          child: Divider(
                            color: AppColors.yellow,
                            thickness: 1,
                            indent: 10,
                            endIndent: width * 0.05,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Google Login
                    ElevatedButton.icon(
                      onPressed: isLoading
                          ? null
                          : () {
                        context.read<AuthBloc>().add(GoogleLoginRequested());
                      },
                      icon: Image.asset(AppAssets.google, height: 24, width: 24),
                      label: Text(loc.loginWithGoogle, style: AppTextStyles.blackRegular20),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.yellow,
                        minimumSize: Size(width * 0.9, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            SizedBox(height: height * 0.02),

            // Language Switcher
            LanguageSwitcher(), // ✅ مش هنبعت onLocaleChange بعد كده
          ],
        ),
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
  bool isArabic = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final localeProvider = Provider.of<LocaleProvider>(context); // ✅ Provider

    // تحديث الزر حسب اللغة الحالية
    isArabic = localeProvider.locale.languageCode == 'ar';

    return GestureDetector(
      onTap: () {
        final newLocale = isArabic ? const Locale('en') : const Locale('ar');
        localeProvider.setLocale(newLocale);
      },
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
            Align(alignment: Alignment.centerRight, child: Image.asset(AppAssets.eg)),
            Align(alignment: Alignment.centerLeft, child: Image.asset(AppAssets.us)),
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
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