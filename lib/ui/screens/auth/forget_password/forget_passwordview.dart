import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/constants/app_assets.dart';
import '../authbloc/authbloc.dart';
import '../authbloc/authevent.dart';

/// ========================= ForgetPasswordView =========================
class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

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
                    hintText: "Email",
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
                      return "Please enter your email";
                    }
                    if (!isValidEmail(value)) {
                      return "Please enter a valid email";
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
                  'Verify Email',
                  style: AppTextStyles.blackRegular20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
