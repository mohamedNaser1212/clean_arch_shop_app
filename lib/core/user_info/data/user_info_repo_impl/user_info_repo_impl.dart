import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:shop_app/core/errors_manager/failure.dart';
import 'package:shop_app/core/managers/repo_manager/repo_manager.dart';

import '../../../../Features/settings_feature/domain/user_entity/user_entity.dart';
import '../../domain/user_info_repo/user_info_repo.dart';
import '../user_info_data_sources/user_info_local_data_source.dart';
import '../user_info_data_sources/user_info_remote_data_source.dart';

class UserInfoRepoImpl implements UserInfoRepo {
  final UserInfoRemoteDataSource remoteDataSource;
  final UserInfoLocalDataSource userLocalDataSource;
  final RepoManager repoManager;

  UserInfoRepoImpl({
    required this.remoteDataSource,
    required this.userLocalDataSource,
    required this.repoManager,
  });

  @override
  Future<Either<Failure, UserEntity>> getUser() async {
    return repoManager.call(
      action: () async {
        final cachedUserData = await userLocalDataSource.loadUserData();

        if (cachedUserData != null) {
          return cachedUserData;
        }
        final userData = await remoteDataSource.getUser();
        await userLocalDataSource.saveUserData(user: userData);
        return userData;
      },
    );
  }
}
