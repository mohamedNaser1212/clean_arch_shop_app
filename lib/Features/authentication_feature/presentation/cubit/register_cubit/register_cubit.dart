import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/features/authentication_feature/data/model/register_request_model.dart';
import 'package:shop_app/features/authentication_feature/domain/authentication_use_case/register_use_case.dart';
import 'package:shop_app/core/networks/hive_manager/hive_helper.dart';
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

  LocalStorageManager? hiveService;

  Future<void> userRegister({
    required RegisterRequestModel requestModel,
  }) async {
    emit(RegisterLoadingState());

    final result = await loginUseCase.call(
      requestModel: requestModel,
    );

    result.fold(
      (failure) {
        emit(RegisterErrorState(message: failure.message));
      },
      (userModel) async {
        emit(RegisterSuccessState(userModel: userModel));
      },
    );
  }
}
