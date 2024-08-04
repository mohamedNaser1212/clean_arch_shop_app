import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/login_model.dart';
import '../../../domain/use_case/register_use_case/register_use_case.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.registerUseCase) : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);
  LoginModel? loginModel;
  //DioHelper? dioHelper;
  bool obsecurePassword = true;
  IconData suffixPasswordIcon = Icons.visibility_rounded;
  void changePasswordVisability() {
    obsecurePassword = !obsecurePassword;
    suffixPasswordIcon = obsecurePassword
        ? Icons.visibility_rounded
        : Icons.visibility_off_rounded;
    emit(RegisterChangePasswordVisability());
  }

  final RegisterUseCase registerUseCase;

  Future<void> userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    emit(RegisterLoadingState());
    var result = await registerUseCase.call(email, password, name, phone);
    result.fold((failure) {
      emit(RegisterErrorState(failure.message));
      print(failure.message);
    }, (loginModel) {
      print('Register Success');
      emit(RegisterSuccessState(loginModel: loginModel));
    });
  }
}
