import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/domain/use_case/login_use_case/login_use_case.dart';

import '../../../../../models/login_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginUseCase) : super(AppInitial());

  static LoginCubit get(context) => BlocProvider.of(context);
  LoginUseCase? loginUseCase;

  Future<void> userLogin(
      {required String email, required String password}) async {
    emit(AppLoginLoadingState());
    var result = await loginUseCase!.call(email, password);
    result.fold((failure) {
      emit(AppLoginErrorState(failure.message));
      print(failure.message);
    }, (loginModel) {
      print('Login Success');
      // print(loginModel.data!.name);
      emit(AppLoginSuccessState(loginModel));
    });
  }

  // void userLogin({
  //   required String email,
  //   required String password,
  // }) {
  //   emit(AppLoginLoadingState());
  //   DioHelper.postData(
  //     url: loginEndPoint,
  //     data: {
  //       'email': email,
  //       'password': password,
  //     },
  //     token: token,
  //   ).then((value) {
  //     print(value.data);
  //     loginModel = LoginModel.fromJson(value.data);
  //     print(loginModel!.message);
  //     print(loginModel!.status);
  //     //print(loginModel!.data!.token);
  //     emit(AppLoginSuccessState(
  //       loginModel!,
  //     ));
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(AppLoginErrorState(error.toString()));
  //   });
  // }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(AppChangePasswordVisibilityState());
  }
}
