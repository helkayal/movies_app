import 'package:movies_app/model/user_dm.dart';

abstract class ProfileStates {}

class ProfileInitial extends ProfileStates {}

class ProfileLoading extends ProfileStates {}

class ProfileLoaded extends ProfileStates {
  final UserDataModel user;
  ProfileLoaded(this.user);
}

class ProfileUpdated extends ProfileStates {
  final UserDataModel user;
  ProfileUpdated(this.user);
}

class ProfileDeleted extends ProfileStates {}

class ProfileError extends ProfileStates {
  final String message;
  ProfileError(this.message);
}
