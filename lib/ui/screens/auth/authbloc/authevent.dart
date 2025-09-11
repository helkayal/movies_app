import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

// 🔑 Login
class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

// 📝 Register
class RegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String phone;
  final int avaterId;

  const RegisterRequested({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phone,
    required this.avaterId,
  });

  @override
  List<Object> get props => [
    name,
    email,
    password,
    confirmPassword,
    phone,
    avaterId,
  ];
}

// 🔐 Forget Password
class ForgetPasswordRequested extends AuthEvent {
  final String email;

  const ForgetPasswordRequested(this.email);

  @override
  List<Object> get props => [email];
}

// 🔄 Reset Password
class ResetPasswordRequested extends AuthEvent {
  final String email;
  final String oldPassword;
  final String newPassword;

  const ResetPasswordRequested({
    required this.email,
    required this.oldPassword,
    required this.newPassword,
  });

  @override
  List<Object> get props => [email, oldPassword, newPassword];
}

// auth_event.dart
class GoogleLoginRequested extends AuthEvent {}
