import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Features/carts_feature/data/carts_data_sources/carts_local_data_source.dart';
import 'package:shop_app/Features/home/data/data_sources/home_local_data_source/home_local_data_source.dart';
import 'package:shop_app/Features/settings_feature/data/user_data_data_source/user_remote_remote_data_source.dart';
import 'package:shop_app/core/errors_manager/failure.dart';
import 'package:shop_app/core/networks/api_manager/api_helper.dart';
import 'package:shop_app/core/user_info/data/user_info_data_sources/user_info_local_data_source.dart';

import '../../../../core/user_info/data/user_info_data_sources/user_info_remote_data_source.dart';
import '../../../favourites_feature/data/favourite_data_source/favourites_local_data_source.dart';
import '../../domain/get_user_repo/get_user_repo.dart';
import '../../domain/user_entity/user_entity.dart';

class UserDataRepoImpl implements UserDataRepo {
  final UserInfoRemoteDataSource getUserInfoDataSource;
  final UserRemoteDataSource getUserDataSource;
  final UserInfoLocalDataSource userInfoLocalDataSource;
  final CartLocalDataSource cartLocalDataSource;
  final FavouritesLocalDataSource favouritesLocalDataSource;
  final HomeLocalDataSource homeLocalDataSource;

  const UserDataRepoImpl({
    required this.getUserInfoDataSource,
    required this.userInfoLocalDataSource,
    required this.getUserDataSource,
    required this.cartLocalDataSource,
    required this.favouritesLocalDataSource,
    required this.homeLocalDataSource,
  });

  @override
  Future<Either<Failure, UserEntity>> getUserData() async {
    try {
      final cachedUserData = await userInfoLocalDataSource.loadUserData();

      if (cachedUserData != null) {
        return Right(cachedUserData);
      } else {
        final userData = await getUserInfoDataSource.getUser();
        await userInfoLocalDataSource.saveUserData(user: userData);
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
      final userData = await getUserDataSource.updateUserData(
          name: name, email: email, phone: phone);
      await userInfoLocalDataSource.saveUserData(user: userData);
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
      final result = await getUserDataSource.signOut(
        context: context,
        apiService: apiService,
      );

      if (result) {
        await cartLocalDataSource.clearCart();

        await favouritesLocalDataSource.clearFavourites();

        await userInfoLocalDataSource.clearUserData();
        await homeLocalDataSource.clearProducts();
      }

      return Right(result);
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }
}
