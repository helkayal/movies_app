import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/constants/app_routes.dart';
import '../../../../data/datasources/Api/authapi.dart';
import '../../../../data/datasources/Api/dioclient.dart';
import '../authbloc/authbloc.dart';
import '../authbloc/authstate.dart';
import 'loginview.dart';
import '../../../../l10n/app_localizations.dart';
class LoginScreen extends StatelessWidget {
  final void Function(Locale)? onLocaleChange; // 👈 هنا نضيف الفانكشن

  const LoginScreen({super.key, this.onLocaleChange}); // 👈 نمرره كـ named parameter

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(authApis: AuthApis(DioClient())),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushReplacement(context, AppRoutes.home);
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          } else if (state is AuthSuccessMessage) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return LoginView(
            isLoading: state is AuthLoading,
            onLocaleChange: onLocaleChange ?? (_) {}, // 👈 نمررها للـ LoginView
          );
        },
      ),
    );
  }
}
