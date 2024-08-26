import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:shop_app/core/errors_manager/failure.dart';

import '../../../../Features/settings_feature/data/user_data_data_source/user_local_data_source.dart';
import '../../../../Features/settings_feature/domain/user_entity/user_entity.dart';
import '../../domain/user_info_repo/user_info_repo.dart';
import '../user_info_data_sources/user_info_remote_data_source.dart';

class UserInfoRepoImpl implements UserInfoRepo {
  final UserInfoRemoteDataSource remoteDataSource;
  final UserLocalDataSource userLocalDataSource;

  UserInfoRepoImpl({
    required this.remoteDataSource,
    required this.userLocalDataSource,
  });

  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    try {
      final cachedUserData = await userLocalDataSource.loadUserData();

      if (cachedUserData != null) {
        return Right(cachedUserData);
      } else {
        final userData = await remoteDataSource.getUser();
        await userLocalDataSource.saveUserData(user: userData);
        return Right(userData);
      }
    } catch (error) {
      return Left(ServerFailure(message: error.toString()));
    }
  }
}
