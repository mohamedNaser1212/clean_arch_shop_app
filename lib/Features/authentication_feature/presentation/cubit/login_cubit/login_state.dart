import 'package:shop_app/Features/settings_feature/domain/user_entity/user_entity.dart';

class LoginState {}

class AppLoginLoadingState extends LoginState {}

class AppLoginSuccessState extends LoginState {
  final UserEntity userModel;
  AppLoginSuccessState({
    required this.userModel,
  });
}

class AppLoginErrorState extends LoginState {
  final String error;
  AppLoginErrorState({
    required this.error,
  });
}


