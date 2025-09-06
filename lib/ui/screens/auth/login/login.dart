import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Theme & Utils
import '../../../../core/utils/constants/app_routes.dart';

// Auth APIs
import '../../../../data/datasources/Api/authapi.dart';
import '../../../../data/datasources/Api/dioclient.dart';

// Auth Bloc
import '../authbloc/authbloc.dart';
import '../authbloc/authstate.dart';

// Screens
import 'loginview.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(authApis: AuthApis(DioClient())),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          // حالة النجاح في تسجيل الدخول
          if (state is LoginSuccess) {
            Navigator.pushReplacement(context, AppRoutes.home);
          }
          // حالة الفشل
          else if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
          // أي رسالة نجاح أخرى
          else if (state is AuthSuccessMessage) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            return LoginView(); // الشاشة الأساسية لتسجيل الدخول
          },
        ),
      ),
    );
  }
}
