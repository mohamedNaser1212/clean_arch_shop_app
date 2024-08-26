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
      // final isLoggedIn = await remoteDataSource
      //     .checkUserStatus(apiService: apiService)
      //     .timeout(const Duration(seconds: 5), onTimeout: () {
      //   navigateAndFinish(context: context, screen: LoginScreen());
      //   throw TimeoutException('Connection timed out');
      // });
      final isLoggedIn = await localDataSource.getUserToken();

      // final isLoggedIn = await remoteDataSource
      //     .checkUserStatus(
      //   apiService: apiService,
      // )
      //     .timeout(const Duration(seconds: 10), onTimeout: () {
      //   navigateAndFinish(context: context, screen: LoginScreen());
      //   throw TimeoutException('Connection timed out');
      // });

      if (isLoggedIn != null) {
        navigateAndFinish(context: context, screen: const LayoutScreen());
      } else {
        navigateAndFinish(context: context, screen: LoginScreen());
      }
      return const Right(true);
    } catch (error) {
      if (error is TimeoutException) {
        return const Left(
            ServerFailure(message: 'Connection timed out, please try again'));
      } else {
        navigateAndFinish(context: context, screen: LoginScreen());
        return const Left(ServerFailure(message: 'Error checking user status'));
      }
    }
  }
}
