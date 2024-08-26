part of 'user_data_cubit.dart';

class GetUserDataState {}

class GetUserDataLoading extends GetUserDataState {}

class GetUserDataSuccess extends GetUserDataState {
  final UserEntity loginModel;
  GetUserDataSuccess(this.loginModel);
}

class GetUserDataError extends GetUserDataState {
  final String error;
  GetUserDataError(this.error);
}

class UpdateUserDataSuccess extends GetUserDataState {
  final UserEntity loginModel;
  UpdateUserDataSuccess(this.loginModel);
}

class UpdateUserDataError extends GetUserDataState {
  final String error;
  UpdateUserDataError(this.error);
}

class UpdateUserDataLoading extends GetUserDataState {}

class GetUserDataSignedOutSuccess extends GetUserDataState {}

class UserSignOutError extends GetUserDataState {
  final String error;
  UserSignOutError({
    required this.error,
  });
}

class UserSignOutLoading extends GetUserDataState {}

class UserSignOutSuccess extends GetUserDataState {}
