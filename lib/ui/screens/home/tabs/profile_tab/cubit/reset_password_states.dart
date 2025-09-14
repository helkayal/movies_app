abstract class ResetPasswordStates {}

class ResetPasswordIntial extends ResetPasswordStates {}

class PasswordResetLoading extends ResetPasswordStates {}

class PasswordResetSuccess extends ResetPasswordStates {}

class PasswordResetError extends ResetPasswordStates {
  final String message;
  PasswordResetError(this.message);
}
