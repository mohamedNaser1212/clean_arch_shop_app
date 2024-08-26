import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';
import 'package:shop_app/core/user_info/domain/use_cases/get_user_info_use_case.dart';

import '../../../../../core/networks/api_manager/api_helper.dart';
import '../../../../authentication_feature/data/authentication_models/authentication_model.dart';
import '../../../../carts_feature/presentation/cubit/carts_cubit.dart';
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
          emit(GetUserDataError(failure.toString()));
        },
        (user) {
          userModel = user;
          emit(GetUserDataSuccess(user));
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
        emit(UpdateUserDataError(failure.toString()));
      },
      (user) {
        userModel = user;
        getUserData();
        emit(UpdateUserDataSuccess(user));
      },
    );
  }

  Future<void> signOut(
    BuildContext context,
    ApiHelper apiService,
  ) async {
    emit(UserSignOutLoading());

    final result = await userSignOutUseCase.call(
      context: context,
      apiService: apiService,
    );

    result.fold(
      (failure) {
        emit(UserSignOutError(error: failure.toString()));
      },
      (success) {
        emit(UserSignOutSuccess());
      },
    );
  }

  Future<void> registerNewUser({
    required AuthenticationModel user,
    required BuildContext context,
  }) async {
    await clearUserData();
    if (context.mounted) {
      CartsCubit.get(context).carts.clear();
      FavouritesCubit.get(context).favorites.clear();
    }
  }

  Future<void> clearUserData() async {
    final userBox = Hive.box('userBox');
    await userBox.clear();
  }
}
