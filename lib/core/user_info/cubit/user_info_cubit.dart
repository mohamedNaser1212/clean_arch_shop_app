import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/core/user_info/domain/use_cases/check_user_status_use_case.dart';

import '../../networks/api_manager/api_helper.dart';
import '../domain/use_cases/get_token_use_case.dart';
import '../domain/use_cases/save_token_use_case.dart';

part 'user_info_state.dart';

class UserInfoCubit extends Cubit<UserInfoState> {
  UserInfoCubit({
    required this.saveTokenUseCase,
    required this.getTokenUseCase,
    required this.checkUserStatusUseCase,
  }) : super(UserInfoState());

  final GetTokenUseCase getTokenUseCase;
  final SaveTokenUseCase saveTokenUseCase;
  final CheckUserStatusUseCase checkUserStatusUseCase;

  Future<void> saveToken({
    required String token,
  }) async {
    emit(SaveTokenLoadingState());

    var result = await saveTokenUseCase.call(token: token);
    result.fold(
      (failure) {
        emit(SaveTokenErrorState(message: failure.message));
        print(failure.message);
      },
      (success) async {
        print('Token Saved');
        emit(SaveTokenSuccessState());
      },
    );
  }

  Future<void> getToken() async {
    emit(GetTokenLoadingState());

    var result = await getTokenUseCase.call();
    result.fold(
      (failure) {
        emit(GetTokenErrorState(message: failure.message));
        print(failure.message);
      },
      (token) async {
        print('Token: $token');
        emit(GetTokenSuccessState(token: token ?? ''));
      },
    );
  }

  Future<bool> checkUserStatus({
    required ApiHelper apiService,
    required BuildContext context,
  }) async {
    emit(CheckUserStatusLoadingState());

    var result = await checkUserStatusUseCase.call(
        apiService: apiService, context: context);
    return result.fold(
      (failure) {
        emit(CheckUserStatusErrorState(message: failure.message));
        print(failure.message);
        return false;
      },
      (token) async {
        print('Token: $token');
        emit(CheckUserStatusSuccessState(token: token));
        return true;
      },
    );
  }
}
