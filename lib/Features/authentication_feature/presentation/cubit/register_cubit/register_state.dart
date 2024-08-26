part of 'register_cubit.dart';

class RegisterState {}

class RegisterSuccessState extends RegisterState {
  UserEntity loginModel;

  RegisterSuccessState({required this.loginModel});
}

class RegisterLoadingState extends RegisterState {}

class RegisterErrorState extends RegisterState {
  final String message;

  RegisterErrorState(this.message);
}

class RegisterChangePasswordVisability extends RegisterState {}
