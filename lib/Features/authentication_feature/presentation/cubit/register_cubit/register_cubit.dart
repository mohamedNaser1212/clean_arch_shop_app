import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/authentication_feature/domain/authentication_use_case/register_use_case.dart';
import 'package:shop_app/core/networks/Hive_manager/hive_helper.dart';
import 'package:shop_app/core/user_info/domain/use_cases/get_user_info_use_case.dart';

import '../../../../settings_feature/domain/user_entity/user_entity.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase loginUseCase;
  final GetUserInfoUseCase userDataUseCase;

  RegisterCubit({
    required this.loginUseCase,
    required this.userDataUseCase,
  }) : super(RegisterState());

  static RegisterCubit get(BuildContext context) => BlocProvider.of(context);

  bool obsecurePassword = true;
  IconData suffixPasswordIcon = Icons.visibility_rounded;
  LocalStorageManager? hiveService;

  //UserEntity? userModel;
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
        emit(RegisterErrorState(message: failure.message));
      },
      (userModel) async {
        final userDataResult = await userDataUseCase.call();
        userDataResult.fold(
          (failure) {
            emit(RegisterErrorState(message: failure.message));
          },
          (userData) {
            emit(RegisterSuccessState(userModel: userData!));
          },
        );
        emit(RegisterSuccessState(userModel: userModel));
      },
    );
  }
}
