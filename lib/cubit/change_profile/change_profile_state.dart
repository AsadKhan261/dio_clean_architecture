part of 'change_profile_cubit.dart';

@immutable
abstract class ChangeProfileState {}

class ChangeProfileInitial extends ChangeProfileState {}

class ChangeProfileLoading extends ChangeProfileState {}

class ChangeProfileLoaded extends ChangeProfileState {
  final ChangeProfileModel changeProfileModel;
  ChangeProfileLoaded(this.changeProfileModel);
}

class ChangeProfileError extends ChangeProfileState {}
