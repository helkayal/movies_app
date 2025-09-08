import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

// الحالة الابتدائية
class AuthInitial extends AuthState {}

// حالة التحميل
class AuthLoading extends AuthState {}

// ✅ Login Success
class LoginSuccess extends AuthState {
  final String message;
  final String token;

  const LoginSuccess({required this.message, required this.token});

  @override
  List<Object?> get props => [message, token];
}

// ✅ Register Success
class RegisterSuccess extends AuthState {
  final String message;
  final Map<String, dynamic> data;

  const RegisterSuccess({required this.message, required this.data});

  @override
  List<Object?> get props => [message, data];
}

// ✅ Success Message (مثلاً: Check your email)
class AuthSuccessMessage extends AuthState {
  final String message;

  const AuthSuccessMessage({required this.message});

  @override
  List<Object?> get props => [message];
}

// ❌ حالة الفشل
class AuthFailure extends AuthState {
  final String error;

  const AuthFailure(this.error);

  @override
  List<Object?> get props => [error];
}
