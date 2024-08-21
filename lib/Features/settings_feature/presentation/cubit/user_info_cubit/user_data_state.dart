part of 'user_data_cubit.dart';

class GetUserDataState {}

class GetUserDataInitial extends GetUserDataState {}

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
