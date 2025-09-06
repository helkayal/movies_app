// lib/ui/screens/auth/authbloc/authbloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../authapi/authapi.dart';
import '../../../../authapi/loginwithgmail.dart';
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
        emit(LoginSuccess(
          message: result['message'] ?? 'Login Successful',
          token: result['token'] ?? '',
        ));
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
          emit(LoginSuccess(
            message: "Login Successful with Google",
            token: await userCredential.user?.getIdToken() ?? "",
          ));
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
        emit(AuthSuccessMessage(
          message: result['message'] ?? 'Check your email',
        ));
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
        emit(AuthSuccessMessage(
          message: result['message'] ?? 'Password Reset Successful',
        ));
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
        emit(RegisterSuccess(
          message: result['message'] ?? 'Register Successful',
          data: result['data'] ?? {},
        ));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}
