part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  AuthenticationModel loginModel;

  RegisterSuccessState({required this.loginModel});
}

class RegisterLoadingState extends RegisterState {}

class RegisterErrorState extends RegisterState {
  final String message;

  RegisterErrorState(this.message);
}

class RegisterChangePasswordVisability extends RegisterState {}
