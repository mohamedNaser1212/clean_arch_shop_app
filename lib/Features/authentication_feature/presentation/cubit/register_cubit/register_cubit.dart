import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/Features/authentication_feature/domain/authentication_use_case/register_use_case.dart';
import 'package:shop_app/core/networks/Hive_manager/hive_helper.dart';

import '../../../../authentication_feature/data/authentication_models/authentication_model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase loginUseCase;

  RegisterCubit(this.loginUseCase) : super(RegisterState());

  static RegisterCubit get(BuildContext context) => BlocProvider.of(context);

  bool obsecurePassword = true;
  IconData suffixPasswordIcon = Icons.visibility_rounded;
  HiveHelper? hiveService;
  Future<void> userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    emit(RegisterLoadingState());

    final result = await loginUseCase.call(
        email: email, password: password, name: name, phone: phone);

    result.fold(
      (failure) {
        emit(RegisterErrorState(failure.message));
        Fluttertoast.showToast(
          msg: failure.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      },
      (loginModel) async {
        emit(RegisterSuccessState(loginModel: loginModel));
      },
    );
  }
}
