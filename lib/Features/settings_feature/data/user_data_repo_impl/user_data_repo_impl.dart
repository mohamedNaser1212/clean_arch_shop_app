import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/core/user_info/data/user_info_data_sources/user_info_local_data_source.dart';

import '../../../../core/errors_manager/failure.dart';
import '../../../../core/networks/api_manager/api_helper.dart';
import '../../../authentication_feature/presentation/screens/login_screen.dart';
import '../../../carts_feature/presentation/cubit/carts_cubit.dart';
import '../../../favourites_feature/presentation/cubit/favourites_cubit.dart';
import '../../domain/get_user_repo/get_user_repo.dart';
import '../../domain/user_entity/user_entity.dart';
import '../user_data_data_source/user_local_data_source.dart';
import '../user_data_data_source/user_remote_remote_data_source.dart';

class UserDataRepoImpl implements UserDataRepo {
  final UserRemoteDataSource getUserDataDataSource;
  final UserLocalDataSource userLocalDataSource;
  final UserInfoLocalDataSource userInfoLocalDataSource;

  const UserDataRepoImpl({
    required this.getUserDataDataSource,
    required this.userLocalDataSource,
    required this.userInfoLocalDataSource,
  });

  @override
  Future<Either<Failure, UserEntity>> getUserData() async {
    try {
      final cachedUserData = await userLocalDataSource.loadUserData();

      if (cachedUserData != null) {
        return Right(cachedUserData);
      } else {
        final userData = await getUserDataDataSource.getUserData();
        await userLocalDataSource.saveUserData(user: userData);
        //     await userInfoLocalDataSource.saveToken(token: userData.token);
        //   await userInfoLocalDataSource.getUserToken();
        return Right(userData);
      }
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateUserData({
    required String name,
    required String email,
    required String phone,
  }) async {
    try {
      final userData = await getUserDataDataSource.updateUserData(
          name: name, email: email, phone: phone);
      await userLocalDataSource.saveUserData(user: userData);
      await userInfoLocalDataSource.saveToken(token: userData.token);
      return Right(userData);
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> signOut({
    required BuildContext context,
    required ApiHelper apiService,
  }) async {
    try {
      final result = await getUserDataDataSource.signOut(
        context: context,
        apiService: apiService,
      );
      await userInfoLocalDataSource.clearUserData();
      await userLocalDataSource.clearUserData();

      if (context.mounted) {
        CartsCubit.get(context).carts.clear();
        FavouritesCubit.get(context).favorites.clear();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
      return Right(result);
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }
}
