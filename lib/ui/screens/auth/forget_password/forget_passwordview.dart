import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../authbloc/authbloc.dart';
import '../authbloc/authevent.dart';

class ForgetPasswordView extends StatefulWidget {
  final void Function(Locale) onLocaleChange;

  const ForgetPasswordView({super.key, required this.onLocaleChange});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: height * 0.01),
              Image.asset(AppAssets.forgetPassword),
              SizedBox(height: height * 0.04),

              // Email
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                child: TextFormField(
                  controller: emailController,
                  style: AppTextStyles.whiteRegular16,
                  decoration: InputDecoration(
                    hintText: loc.email,
                    hintStyle: AppTextStyles.whiteRegular16,
                    filled: true,
                    fillColor: AppColors.darkGrey,
                    prefixIcon: Image.asset(AppAssets.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return loc.enterEmail;
                    }
                    if (!isValidEmail(value)) {
                      return loc.enterValidEmail;
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: height * 0.03),

              // زرار Verify Email
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<AuthBloc>().add(
                      ForgetPasswordRequested(emailController.text),
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
                  loc.verifyEmail,
                  style: AppTextStyles.blackRegular20,
                ),
              ),

              SizedBox(height: height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
