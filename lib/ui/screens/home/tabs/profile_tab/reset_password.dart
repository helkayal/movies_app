import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/theme/app_colors.dart';
import 'package:movies_app/core/utils/constants/app_assets.dart';
import 'package:movies_app/core/utils/constants/app_routes.dart';
import 'package:movies_app/core/utils/context_extension.dart';
import 'package:movies_app/ui/screens/home/tabs/profile_tab/cubit/profile_cubit.dart';
import 'package:movies_app/ui/screens/home/tabs/profile_tab/cubit/reset_password_cubit.dart';
import 'package:movies_app/ui/screens/home/tabs/profile_tab/cubit/reset_password_states.dart';
import 'package:movies_app/ui/widgets/custom_button.dart';
import 'package:movies_app/ui/widgets/custom_text_field.dart';
import '../../../../../l10n/app_localizations.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final passwordFormKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (_) => ResetPasswordCubit(),
      child: BlocConsumer<ResetPasswordCubit, ResetPasswordStates>(
        listener: (ctx, state) {
          if (state is PasswordResetSuccess) {
            context.showSnackBar(loc.passwordResetSuccessfully);
            context.read<ProfileCubit>().logOut();
            Navigator.pushReplacement(context, AppRoutes.login);
          } else if (state is PasswordResetError) {
            context.showSnackBar(state.message);
          }
        },
        builder: (ctx, state) {
          final isLoading = state is PasswordResetLoading;

          return Scaffold(
            appBar: AppBar(
              title: Text(loc.resetPassword),
              leading: IconButton(
                onPressed: () => Navigator.pop(context, false),
                icon: Icon(Icons.arrow_back, color: AppColors.yellow),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: passwordFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextField(
                      hint: loc.oldPassword,
                      controller: oldPasswordController,
                      prefixIcon: Image.asset(AppAssets.lock),
                      isPassword: true,
                      validator: (value) => value == null || value.isEmpty
                          ? loc.enterPassword
                          : null,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      hint: loc.newPassword,
                      controller: newPasswordController,
                      prefixIcon: Image.asset(AppAssets.lock),
                      isPassword: true,
                      validator: (value) => value == null || value.isEmpty
                          ? loc.enterPassword
                          : null,
                    ),
                    const SizedBox(height: 24),
                    if (isLoading)
                      const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.yellow,
                        ),
                      )
                    else
                      CustomButton(
                        text: loc.reset,
                        onClick: () {
                          if (passwordFormKey.currentState!.validate()) {
                            ctx.read<ResetPasswordCubit>().resetPassword(
                              oldPassword: oldPasswordController.text.trim(),
                              newPassword: newPasswordController.text.trim(),
                            );
                          }
                        },
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
