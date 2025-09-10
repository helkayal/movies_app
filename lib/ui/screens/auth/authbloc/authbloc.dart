// lib/ui/screens/auth/authbloc/authbloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/datasources/Api/authapi.dart';
import '../../../../data/datasources/google/google_auth.dart';
import 'authevent.dart';
import 'authstate.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthApis authApis;
  final GoogleAuth googleAuth = GoogleAuth();

  AuthBloc({required this.authApis}) : super(AuthInitial()) {
    // 🔑 Email/Password Login
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await authApis.login(event.email, event.password);

        // ✅ خزّن التوكن
        final prefs = await SharedPreferences.getInstance();
        // await prefs.setString("token", result['token'] ?? '');
        await prefs.setBool("isGoogleLoggedIn", false);
        await prefs.setString("email", event.email);

        emit(
          LoginSuccess(
            message: result['message'] ?? 'Login Successful',
            token: result['token'] ?? '',
          ),
        );
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    // 🔑 Google Login
    on<GoogleLoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final userCredential = await googleAuth.loginWithGoogle();
        if (userCredential != null) {
          final user = userCredential.user;
          final token = await user?.getIdToken() ?? "";

          final FlutterSecureStorage storage = const FlutterSecureStorage();
          await storage.write(key: 'token', value: token);

          // ✅ خزّن بيانات جوجل
          final prefs = await SharedPreferences.getInstance();
          // await prefs.setString("token", token);
          // await prefs.setString("name", user?.displayName ?? "Guest");
          await prefs.setString("email", user?.email ?? "");
          // await prefs.setString("photoUrl", user?.photoURL ?? "");
          await prefs.setBool("isGoogleLoggedIn", true);

          emit(
            LoginSuccess(message: "Login Successful with Google", token: ""),
          );
        } else {
          emit(AuthFailure("Google Sign-In canceled"));
        }
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    // 🔐 Forget Password
    on<ForgetPasswordRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await authApis.forgetPassword(event.email);
        emit(
          AuthSuccessMessage(message: result['message'] ?? 'Check your email'),
        );
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    // 🔄 Reset Password
    on<ResetPasswordRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await authApis.resetPassword(
          email: event.email,
          oldPassword: event.oldPassword,
          newPassword: event.newPassword,
        );
        emit(
          AuthSuccessMessage(
            message: result['message'] ?? 'Password Reset Successful',
          ),
        );
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    // 📝 Register
    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final result = await authApis.register(
          name: event.name,
          email: event.email,
          password: event.password,
          confirmPassword: event.confirmPassword,
          phone: event.phone,
          avaterId: event.avaterId,
        );

        // ✅ خزّن التوكن من الريجيستر
        final prefs = await SharedPreferences.getInstance();
        if (result['data']?['token'] != null) {
          await prefs.setString("token", result['data']['token']);
        }

        emit(
          RegisterSuccess(
            message: result['message'] ?? 'Register Successful',
            data: result['data'] ?? {},
          ),
        );
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}
