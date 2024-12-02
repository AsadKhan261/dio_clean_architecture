part of 'user_profile_cubit.dart';

@immutable
abstract class UserProfileState {}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}


class UserProfileLoaded extends UserProfileState {
  final UserProfileModel userProfileModel;
  UserProfileLoaded(this.userProfileModel);
}


class UserProfileError extends UserProfileState {}

