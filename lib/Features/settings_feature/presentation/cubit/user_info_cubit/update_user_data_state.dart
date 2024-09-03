part of 'update_user_data_cubit.dart';

class UpdateUserDataState {}

class UpdateUserDataSuccess extends UpdateUserDataState {
  final UserEntity userEntity;
  UpdateUserDataSuccess({
    required this.userEntity,
  });
}

class UpdateUserDataError extends UpdateUserDataState {
  final String error;
  UpdateUserDataError({
    required this.error,
  });
}

class UpdateUserDataLoading extends UpdateUserDataState {}
