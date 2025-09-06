import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../authapi/authapi.dart';
import '../../../../authapi/dioclient.dart';
import '../../../../authapi/loginwithgmail.dart';
import '../../../utils/app_routes.dart';
import '../authbloc/authbloc.dart';
import '../authbloc/authstate.dart';
import 'loginview.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(
        authApis: AuthApis(DioClient()),
      ),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is LoginSuccess) {
            Navigator.pushReplacement(context, AppRoutes.home);
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is AuthSuccessMessage) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            return  LoginView(); // الشاشة الأساسية لتسجيل الدخول
          },
        ),
      ),
    );
  }
}
