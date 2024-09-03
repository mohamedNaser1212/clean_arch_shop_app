import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';
import 'package:shop_app/core/networks/Hive_manager/hive_boxes_names.dart';
import 'package:shop_app/core/user_info/domain/use_cases/get_user_info_use_case.dart';

import '../../../../../core/networks/api_manager/api_manager.dart';
import '../../../../../core/utils/widgets/constants.dart';
import '../../../../authentication_feature/data/user_model/user_model.dart';
import '../../../../settings_feature/domain/user_entity/user_entity.dart';
import '../../../domain/settings_use_case/update_user_data_use_case.dart';
import '../../../domain/settings_use_case/user_sign_out_use_case.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<GetUserDataState> {
  final GetUserInfoUseCase getInfoUserDataUseCase;

  final UpdateUserDataUseCase updateUserDataUseCase;
  final UserSignOutUseCase userSignOutUseCase;

  UserDataCubit({
    required this.updateUserDataUseCase,
    required this.getInfoUserDataUseCase,
    required this.userSignOutUseCase,
  }) : super(GetUserDataState());

  static UserDataCubit get(BuildContext context) => BlocProvider.of(context);

  UserEntity? userModel;

  Future<void> getUserData() async {
    if (userModel != null) {
      emit(GetUserDataSuccess(userModel!));
    } else {
      final result = await getInfoUserDataUseCase.call();
      result.fold(
        (failure) {
          emit(GetUserDataError(error: failure.message));
        },
        (user) {
          userModel = user;
          emit(GetUserDataSuccess(user!));
        },
      );
    }
  }

  bool checkDataChanges({
    required String name,
    required String email,
    required String phone,
  }) {
    return userModel != null &&
        (name != userModel!.name ||
            email != userModel!.email ||
            phone != userModel!.phone);
  }

  Future<void> updateUserData({
    required String name,
    required String email,
    required String phone,
  }) async {
    emit(GetUserDataLoading());
    final result = await updateUserDataUseCase.call(
      name: name,
      email: email,
      phone: phone,
    );
    result.fold(
      (failure) {
        emit(UpdateUserDataError(failure.message));
      },
      (user) {
        userModel = user;
        getUserData();
        emit(UpdateUserDataSuccess(user));
      },
    );
  }

  Future<void> signOut(
    ApiManager apiService,
  ) async {
    emit(UserSignOutLoading());

    final result = await userSignOutUseCase.call(
      apiService: apiService,
    );

    result.fold(
      (failure) {
        emit(UserSignOutError(error: failure.message));
      },
      (success) {
        emit(UserSignOutSuccess());
      },
    );
  }

  Future<void> registerNewUser({
    required UserModel user,
    required BuildContext context,
  }) async {
    await clearUserData();
    if (context.mounted) {
      carts.clear();
      FavouritesCubit.get(context).favorites.clear();
    }
  }

  Future<void> clearUserData() async {
    final userBox = Hive.box(HiveBoxesNames.kUserBox);
    await userBox.clear();
  }
}
