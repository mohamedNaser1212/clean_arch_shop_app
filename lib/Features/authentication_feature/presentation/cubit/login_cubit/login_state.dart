import 'package:shop_app/Features/authentication_feature/data/authentication_models/authentication_model.dart';

class LoginState {}

class AppLoginLoadingState extends LoginState {}

class AppLoginSuccessState extends LoginState {
  final AuthenticationModel loginMode;
  AppLoginSuccessState(this.loginMode);
}

class AppLoginErrorState extends LoginState {
  final String error;
  AppLoginErrorState(this.error);
}

class AppChangePasswordVisibilityState extends LoginState {}
