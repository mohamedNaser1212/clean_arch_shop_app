import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/core/errors/failure.dart';

import '../../../../core/networks/api_manager/api_service_interface.dart';
import '../../domain/get_user_repo/get_user_repo.dart';
import '../../domain/user_entity/user_entity.dart';
import '../user_data_data_source/save_user_data.dart';
import '../user_data_data_source/user_info_remote_data_source.dart';

class UserDataRepoImpl implements UserDataRepo {
  final UserDataSource getUserDataDataSource;
  final UserLocalDataSource userLocalDataSource;

  const UserDataRepoImpl({
    required this.getUserDataDataSource,
    required this.userLocalDataSource,
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
        return Right(userData);
      }
    } catch (error) {
      return Left(ServerFailure(error.toString()));
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
      return Right(userData);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> signOut({
    required BuildContext context,
    required ApiServiceInterface apiService,
  }) async {
    try {
      final result = await getUserDataDataSource.signOut(
        context: context,
        apiService: apiService,
      );
      await userLocalDataSource.clearUserData();

      return Right(result);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }
}
