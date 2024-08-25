import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/authentication_feature/domain/authentication_use_case/login_use_case.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required this.loginUseCase,
  }) : super(LoginState());

  static LoginCubit get(context) => BlocProvider.of(context);
  final LoginUseCase loginUseCase;

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    emit(AppLoginLoadingState());

    var result = await loginUseCase.call(email: email, password: password);
    result.fold(
      (failure) {
        emit(AppLoginErrorState(failure.message));
        print(failure.message);
      },
      (loginModel) async {
        print('Login Success');
        emit(AppLoginSuccessState(loginModel));
      },
    );
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(AppChangePasswordVisibilityState());
  }
}
