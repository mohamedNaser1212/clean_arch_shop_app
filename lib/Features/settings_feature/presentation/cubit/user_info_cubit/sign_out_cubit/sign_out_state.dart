part of 'sign_out_cubit.dart';

class SignOutState {}

class UserSignOutError extends SignOutState {
  final String error;
  UserSignOutError({
    required this.error,
  });
}

class UserSignOutLoading extends SignOutState {}

class UserSignOutSuccess extends SignOutState {}
