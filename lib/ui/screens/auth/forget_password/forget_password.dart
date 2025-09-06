import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Theme & Utils
import '../../../../core/theme/app_colors.dart';
import 'package:movies_app/core/theme/app_text_styles.dart';
import 'package:movies_app/core/utils/constants/app_assets.dart';

// Auth APIs
import '../../../../authapi/authapi.dart';
import '../../../../authapi/dioclient.dart';

// Auth Bloc
import '../authbloc/authbloc.dart';
import '../authbloc/authstate.dart';

// Screens
import '../login/login.dart';
import 'forget_passwordview.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(authApis: AuthApis(DioClient())),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          // Loading
          if (state is AuthLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(
                child: CircularProgressIndicator(color: AppColors.white),
              ),
            );
          } else if (Navigator.canPop(context)) {
            Navigator.of(context, rootNavigator: true).pop();
          }

          // Success
          if (state is AuthSuccessMessage) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message ?? "Check your email inbox")),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
          }

          // Failure
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: const ForgetPasswordView(),
      ),
    );
  }
}
