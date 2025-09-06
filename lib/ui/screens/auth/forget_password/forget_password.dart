import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../authapi/authapi.dart';
import '../../../../authapi/dioclient.dart';
import '../../../utils/app_colors.dart';


import '../authbloc/authbloc.dart';
import '../authbloc/authstate.dart';
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
              builder: (_) =>
              const Center(child: CircularProgressIndicator(color: AppColors.white)),
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