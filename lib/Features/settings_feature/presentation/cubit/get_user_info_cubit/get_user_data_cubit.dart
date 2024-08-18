import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/presentation/cubit/shop_cubit/shop_cubit.dart';
import 'package:shop_app/core/widgets/end_points.dart';

import '../../../../../core/widgets/cache_helper.dart';
import '../../../../authentication_feature/data/authentication_models/login_model.dart';
import '../../../../authentication_feature/presentation/screens/login_screen.dart';
import '../../../../settings_feature/domain/settings_use_case/get_user_data_use_case/super_get_user_data_use_case.dart';
import '../../../../settings_feature/domain/user_entity/user_entity.dart';
import '../../../data/user_local_data_source/save_user_data.dart';

part 'get_user_data_state.dart';

class UserDataCubit extends Cubit<GetUserDataState> {
  final SuperGetUserDataUseCase getUserDataUseCase;

  UserDataCubit({required this.getUserDataUseCase})
      : super(GetUserDataInitial());

  static UserDataCubit get(BuildContext context) => BlocProvider.of(context);

  UserEntity? userModel;

  Future<void> getUserData() async {
    emit(GetUserDataLoading());

    if (userModel != null) {
      emit(GetUserDataSuccess(userModel!));
    } else {
      final result = await getUserDataUseCase.GetUserData();
      result.fold(
        (failure) {
          emit(GetUserDataError(failure.toString()));
        },
        (user) {
          userModel = user;
          // saveUserData(user); // Cache the fetched data
          emit(GetUserDataSuccess(user));
        },
      );
    }
  }

  Future<void> updateUserData({
    required String name,
    required String email,
    required String phone,
  }) async {
    emit(GetUserDataLoading());

    final result = await getUserDataUseCase.UpdateUserData(
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
        // saveUserData(user); // Update cached data
        emit(UpdateUserDataSuccess(user));
      },
    );
  }

  Future<void> signOut(BuildContext context) async {
    favorites.clear();
    carts.clear();
    ShopCubit.get(context).currentIndex = 0;

    await clearUserData(); // Clear cached data
    bool removedToken = await CacheHelper.removeData(key: 'token');

    if (removedToken) {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    }
  }

  Future<void> registerNewUser(LoginModel user) async {
    await clearUserData(); // Clear old cached data
    saveUserData(user); // Save new user data
  }
}
