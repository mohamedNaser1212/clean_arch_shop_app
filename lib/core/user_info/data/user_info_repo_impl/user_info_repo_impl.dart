import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/core/errors_manager/failure.dart';
import 'package:shop_app/core/managers/navigations_manager/navigations_manager.dart';
import 'package:shop_app/core/networks/api_manager/api_helper.dart';

import '../../../../Features/authentication_feature/presentation/screens/login_screen.dart';
import '../../../../Features/layout/presentation/screens/layout_screen.dart';
import '../../domain/user_info_repo/user_info_repo.dart';
import '../user_info_data_sources/user_info_local_data_source.dart';
import '../user_info_data_sources/user_info_remote_data_source.dart';

class UserInfoRepoImpl implements UserInfoRepo {
  final UserInfoLocalDataSource localDataSource;
  final UserInfoRemoteDataSource remoteDataSource;

  UserInfoRepoImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, String?>> getUserToken() async {
    try {
      final token = await localDataSource.getUserToken();
      if (token != null) {
        return Right(token);
      } else {
        final remoteToken = await remoteDataSource.getUserToken();
        await localDataSource.saveToken(token: remoteToken);
        return Right(remoteToken);
      }
    } catch (error) {
      return const Left(ServerFailure(message: 'Error getting token'));
    }
  }

  @override
  Future<Either<Failure, void>> saveToken({required String token}) async {
    try {
      await localDataSource.saveToken(token: token);
      return const Right(null);
    } catch (error) {
      return const Left(ServerFailure(message: 'Error saving token'));
    }
  }

  @override
  Future<Either<Failure, bool>> checkUserStatus({
    required BuildContext context,
    required ApiHelper apiService,
  }) async {
    try {
      final token = await localDataSource.getUserToken();
      await Future.delayed(const Duration(seconds: 2));

      if (token != null) {
        navigateAndFinish(context: context, screen: const LayoutScreen());
        return const Right(true);
      } else {
        navigateAndFinish(context: context, screen: LoginScreen());
        return const Right(false);
      }
    } catch (error) {
      navigateAndFinish(context: context, screen: LoginScreen());
      return const Left(ServerFailure(message: 'Error checking user status'));
    }
  }
}
