import 'package:shop_app/Features/settings_feature/domain/user_entity/user_entity.dart';

class LoginState {}

class AppLoginLoadingState extends LoginState {}

class AppLoginSuccessState extends LoginState {
  final UserEntity loginMode;
  AppLoginSuccessState(this.loginMode);
}

class AppLoginErrorState extends LoginState {
  final String error;
  AppLoginErrorState({
    required this.error,
  });
}

class AppChangePasswordVisibilityState extends LoginState {}
