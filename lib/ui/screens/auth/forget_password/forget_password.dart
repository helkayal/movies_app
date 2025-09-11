import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/context_extension.dart';

// Theme & Utils
import '../../../../core/theme/app_colors.dart';

// Auth APIs
import '../../../../data/datasources/Api/authapi.dart';
import '../../../../data/datasources/Api/dioclient.dart';

// Auth Bloc
import '../authbloc/authbloc.dart';
import '../authbloc/authstate.dart';

// Screens
import '../login/login.dart';
import 'forget_passwordview.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final void Function(Locale)? onLocaleChange;
  const ForgetPasswordScreen({super.key, this.onLocaleChange});

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
            context.showSnackBar(state.message);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
          }

          // Failure
          if (state is AuthFailure) {
            context.showSnackBar(state.error);
          }
        },
        child: ForgetPasswordView(onLocaleChange: onLocaleChange ?? (_) {}),
      ),
    );
  }
}
