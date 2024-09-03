import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shop_app/core/networks/Hive_manager/hive_boxes_names.dart';

import '../../../../../core/networks/api_manager/api_manager.dart';
import '../../../../settings_feature/domain/user_entity/user_entity.dart';
import '../../../domain/settings_use_case/user_sign_out_use_case.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<GetUserDataState> {
  final UserSignOutUseCase userSignOutUseCase;

  UserDataCubit({
    required this.userSignOutUseCase,
  }) : super(GetUserDataState());

  static UserDataCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> signOut(ApiManager apiService) async {
    emit(UserSignOutLoading());

    final result = await userSignOutUseCase.call(apiService: apiService);

    result.fold(
      (failure) {
        emit(UserSignOutError(error: failure.message));
      },
      (success) async {
        await clearUserData();
        emit(UserSignOutSuccess());
      },
    );
  }

  Future<void> clearUserData() async {
    final userBox = Hive.box(HiveBoxesNames.kUserBox);
    await userBox.clear();
  }
}
