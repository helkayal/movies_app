import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/utils/context_extension.dart';
import '../../../../core/utils/constants/app_routes.dart';
import '../../../../data/datasources/Api/authapi.dart';
import '../../../../data/datasources/Api/dioclient.dart';
import '../authbloc/authbloc.dart';
import '../authbloc/authstate.dart';
import 'loginview.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key}); // ✅ حذف onLocaleChange

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(authApis: AuthApis(DioClient())),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushReplacement(context, AppRoutes.home);
          } else if (state is AuthFailure) {
            context.showSnackBar(state.error);
          } else if (state is AuthSuccessMessage) {
            context.showSnackBar(state.message);
          }
        },
        builder: (context, state) {
          return LoginView(
            isLoading: state is AuthLoading,
            // ✅ مش محتاجين نمرر onLocaleChange بعد كده
          );
        },
      ),
    );
  }
}
