import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';

import '../../../../../core/networks/api_manager/api_service_interface.dart';
import '../../../../authentication_feature/data/authentication_models/authentication_model.dart';
import '../../../../authentication_feature/presentation/screens/login_screen.dart';
import '../../../../carts_feature/presentation/cubit/carts_cubit.dart';
import '../../../../home/presentation/cubit/products_cubit/get_product_cubit.dart';
import '../../../../settings_feature/domain/user_entity/user_entity.dart';
import '../../../domain/settings_use_case/get_user_data_use_case/update_user_data_use_case.dart';
import '../../../domain/settings_use_case/get_user_data_use_case/user_data_use_case.dart';
import '../../../domain/settings_use_case/get_user_data_use_case/user_sign_out_use_case.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<GetUserDataState> {
  final UserDataUseCase getUserDataUseCase;
  final UpdateUserDataUseCase updateUserDataUseCase;
  final UserSignOutUseCase userSignOutUseCase;

  UserDataCubit({
    required this.updateUserDataUseCase,
    required this.getUserDataUseCase,
    required this.userSignOutUseCase,
  }) : super(GetUserDataInitial());

  static UserDataCubit get(BuildContext context) => BlocProvider.of(context);

  UserEntity? userModel;

  Future<void> getUserData() async {
    if (userModel != null) {
      emit(GetUserDataSuccess(userModel!));
    } else {
      final result = await getUserDataUseCase.getUserData();
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

  Future<void> updateUserData({
    required String name,
    required String email,
    required String phone,
  }) async {
    emit(GetUserDataLoading());

    final result = await updateUserDataUseCase.updateUserData(
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
    emit(GetUserDataLoading());

    final result = await userSignOutUseCase.call(
      context: context,
      apiService: apiService,
    );

    result.fold(
      (failure) {
        emit(GetUserDataError(failure.toString()));
      },
      (success) {
        CartsCubit.get(context).carts.clear();
        FavouritesCubit.get(context).favorites.clear();
        GetProductsCubit.get(context).currentIndex = 0;

        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        }
        emit(GetUserDataSignedOutSuccess());
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
