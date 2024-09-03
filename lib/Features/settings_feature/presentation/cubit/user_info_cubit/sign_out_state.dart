part of 'sign_out_cubit.dart';

class SignOutState {}

class GetUserDataLoading extends SignOutState {}

class GetUserDataSuccess extends SignOutState {
  final UserEntity loginModel;
  GetUserDataSuccess(this.loginModel);
}

class GetUserDataError extends SignOutState {
  final String error;
  GetUserDataError({
    required this.error,
  });
}

class GetUserDataSignedOutSuccess extends SignOutState {}

class UserSignOutError extends SignOutState {
  final String error;
  UserSignOutError({
    required this.error,
  });
}

class UserSignOutLoading extends SignOutState {}

class UserSignOutSuccess extends SignOutState {}
