import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shop_app/core/errors_manager/failure.dart';
import 'package:shop_app/core/errors_manager/internet_failure.dart';
import 'package:shop_app/core/initial_screen/manager/internet_manager/internet_manager.dart';

import '../../../../Features/settings_feature/domain/user_entity/user_entity.dart';
import '../../domain/user_info_repo/user_info_repo.dart';
import '../user_info_data_sources/user_info_local_data_source.dart';
import '../user_info_data_sources/user_info_remote_data_source.dart';

class UserInfoRepoImpl implements UserInfoRepo {
  final UserInfoRemoteDataSource remoteDataSource;
  final UserInfoLocalDataSource userLocalDataSource;
  final InternetManager internetManager;

  UserInfoRepoImpl({
    required this.remoteDataSource,
    required this.userLocalDataSource,
    required this.internetManager,
  });

  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    try {
      final isConnected = await internetManager.checkConnection();
      if (!isConnected) {
        return left(
          InternetFailure.fromConnectionStatus(
              InternetConnectionStatus.disconnected),
        );
      } else {
        final cachedUserData = await userLocalDataSource.loadUserData();

        if (cachedUserData != null) {
          return Right(cachedUserData);
        }
      }

      final userData = await remoteDataSource.getUser();
      await userLocalDataSource.saveUserData(user: userData);
      return Right(userData);
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }
}
