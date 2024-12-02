part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  final LogInModel logInModel;
  LoginLoaded(this.logInModel);
}

class LoginError extends LoginState {}
