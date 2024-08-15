import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shop_app/Features/home/domain/entities/user_entity/user_entity.dart';
import 'package:shop_app/Features/home/domain/use_case/get_user_data_use_case/super_get_user_data_use_case.dart';
import 'package:shop_app/Features/home/presentation/manager/shop_cubit/shop_cubit.dart';
import 'package:shop_app/core/widgets/end_points.dart';
import 'package:shop_app/models/login_model.dart';

import '../../../../../core/widgets/cache_helper.dart';
import '../../../../../screens/login_screen.dart';

part 'get_user_data_state.dart';

class UserDataCubit extends Cubit<GetUserDataState> {
  final SuperGetUserDataUseCase getUserDataUseCase;
  static const String boxName = 'userBox';

  UserDataCubit({required this.getUserDataUseCase})
      : super(GetUserDataInitial());

  static UserDataCubit get(context) => BlocProvider.of(context);

  UserEntity? userModel;

  void getUserData() async {
    emit(GetUserDataLoading());

    UserEntity? cachedUser = await _loadUserData();
    if (cachedUser != null) {
      userModel = cachedUser;
      emit(GetUserDataSuccess(cachedUser));
    } else {
      final result = await getUserDataUseCase.GetUserData();
      result.fold(
        (failure) {
          emit(GetUserDataError(failure.toString()));
        },
        (user) {
          userModel = user;
          _saveUserData(user);
          emit(GetUserDataSuccess(user));
        },
      );
    }
  }

  void updateUserData({
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
        _saveUserData(user);
        emit(UpdateUserDataSuccess(user));
      },
    );
  }

  Future<void> _saveUserData(UserEntity user) async {
    var box = await Hive.openBox<UserEntity>(boxName);
    await box.put('user', user); // Save user data with a key
    print('User data saved to Hive');
  }

  Future<UserEntity?> _loadUserData() async {
    var box = await Hive.openBox<UserEntity>(boxName);
    return box.get('user');
  }

  Future<void> _clearUserData() async {
    var box = await Hive.openBox<UserEntity>(boxName);
    await box.delete('user'); // Clear user data
    print('User data cleared from Hive');
  }

  void signOut(BuildContext context) {
    favorites.clear();
    carts.clear();
    ShopCubit.get(context).currentIndex = 0;
    _clearUserData().then((_) {
      CacheHelper.removeData(key: 'token').then((value) {
        if (value) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        }
      });
    });
  }

  registerNewUser(LoginModel user) async {
    await _clearUserData(); // Clear previous user data
    _saveUserData(user); // Save new user data
  }
}
