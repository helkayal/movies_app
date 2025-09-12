import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/context_extension.dart';
import '../../../../data/datasources/Api/authapi.dart';
import '../../../../data/datasources/Api/dioclient.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/constants/app_routes.dart';
import '../authbloc/authbloc.dart';
import '../authbloc/authstate.dart';
import 'registerview.dart';

class RegisterScreen extends StatelessWidget {
  // final void Function(Locale)? onLocaleChange;
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(
        authApis: AuthApis(DioClient()), // شلنا GoogleAuth
      ),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            // ⬇️ اظهار loading
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(
                child: CircularProgressIndicator(color: AppColors.white),
              ),
            );
          } else if (Navigator.canPop(context)) {
            // ⬆️ قفل أي loading موجود
            Navigator.of(context, rootNavigator: true).pop();
          }

          if (state is RegisterSuccess) {
            context.showSnackBar(state.message);
            // بعد النجاح انتقل للـ Login
            Navigator.pushReplacement(context, AppRoutes.login);
          }

          if (state is AuthFailure) {
            context.showSnackBar(state.error);
          }
        },
        child: RegisterView(),
      ),
    );
  }
}
