part of 'login_cubit.dart';

class LoginState {}

class AppInitial extends LoginState {}

class AppLoginLoadingState extends LoginState {}

class AppLoginSuccessState extends LoginState {
  final LoginModel loginModel;
  AppLoginSuccessState(this.loginModel);
}

class AppLoginErrorState extends LoginState {
  final String error;
  AppLoginErrorState(this.error);
}

class AppChangePasswordVisibilityState extends LoginState {}
