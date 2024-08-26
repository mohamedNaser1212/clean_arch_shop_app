part of 'user_info_cubit.dart';

class UserInfoState {}

class SaveTokenLoadingState extends UserInfoState {}

class SaveTokenSuccessState extends UserInfoState {}

class SaveTokenErrorState extends UserInfoState {
  final String message;

  SaveTokenErrorState({
    required this.message,
  });
}

class GetTokenLoadingState extends UserInfoState {}

class GetTokenSuccessState extends UserInfoState {
  final String token;

  GetTokenSuccessState({required this.token});
}

class GetTokenErrorState extends UserInfoState {
  final String message;

  GetTokenErrorState({
    required this.message,
  });
}

class CheckUserStatusSuccessState extends UserInfoState {
  final bool token;

  CheckUserStatusSuccessState({required this.token});
}

class CheckUserStatusErrorState extends UserInfoState {
  final String message;

  CheckUserStatusErrorState({
    required this.message,
  });
}

class CheckUserStatusLoadingState extends UserInfoState {}
