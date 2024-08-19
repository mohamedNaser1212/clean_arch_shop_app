import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/home/presentation/cubit/shop_cubit/shop_cubit.dart';
import 'package:shop_app/core/utils/api_services/api_service_interface.dart';

import '../../../../../core/models/api_request_model/api_request_model.dart';
import '../../../../../core/utils/screens/widgets/cache_helper.dart';
import '../../../../../core/utils/screens/widgets/end_points.dart';
import '../../../../authentication_feature/data/authentication_models/authentication_model.dart';
import '../../../../authentication_feature/presentation/screens/login_screen.dart';
import '../../../../settings_feature/domain/user_entity/user_entity.dart';
import '../../../data/user_data_data_source/save_user_data.dart';
import '../../../domain/settings_use_case/get_user_data_use_case/update_user_data_use_case.dart';
import '../../../domain/settings_use_case/get_user_data_use_case/user_data_use_case.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<GetUserDataState> {
  final UserDataUseCase getUserDataUseCase;
  final UpdateUserDataUseCase updateUserDataUseCase;

  UserDataCubit(
      {required this.updateUserDataUseCase, required this.getUserDataUseCase})
      : super(GetUserDataInitial());

  static UserDataCubit get(BuildContext context) => BlocProvider.of(context);

  UserEntity? userModel;

  Future<void> getUserData() async {
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

    final result = await updateUserDataUseCase.UpdateUserData(
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

  Future<void> signOut(
      BuildContext context, ApiServiceInterface apiService) async {
    favorites.clear();
    carts.clear();
    ShopCubit.get(context).currentIndex = 0;

    ApiRequestModel request = ApiRequestModel(endpoint: 'logout');
    final response = await apiService.post(request: request);

    bool removedUserData = response['status'];

    if (removedUserData) {
      await clearUserData();
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

    // await clearUserData();
    // bool removedToken = await CacheHelper.removeData(key: 'token');
    //
    // if (removedToken) {
    //   if (context.mounted) {
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(builder: (context) => LoginScreen()),
    //     );
    //   }
    // }
  }

  Future<void> registerNewUser(AuthenticationModel user) async {
    await clearUserData();
    carts.clear();
    favorites.clear();
  }
}
