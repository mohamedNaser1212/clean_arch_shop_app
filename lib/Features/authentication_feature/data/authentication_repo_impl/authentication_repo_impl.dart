import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/authentication_feature/data/model/login_request_model.dart';
import 'package:shop_app/Features/authentication_feature/data/model/register_request_model.dart';
import 'package:shop_app/core/user_info/data/user_info_data_sources/user_info_local_data_source.dart';

import '../../../../core/errors_manager/failure.dart';
import '../../../../core/managers/repo_manager/repo_manager.dart';
import '../../../settings_feature/domain/user_entity/user_entity.dart';
import '../../domain/authentication_repo/authentication_repo.dart';
import '../authentication_data_sources/authentication_remote_data_source.dart';

class AuthRepoImpl implements AuthenticationRepo {
  final AuthenticationRemoteDataSource loginDataSource;
  final UserInfoLocalDataSource userInfoLocalDataSourceImpl;
  final RepoManager repoManager;

  const AuthRepoImpl({
    required this.loginDataSource,
    required this.userInfoLocalDataSourceImpl,
    required this.repoManager,
  });

  @override
  Future<Either<Failure, UserEntity>> login({
    required LoginRequestModel requestModel,
  }) async {
    return repoManager.call(
      action: () async {
        final userEntity =
            await loginDataSource.login(requestModel: requestModel);
        await userInfoLocalDataSourceImpl.saveUserData(user: userEntity);
        return userEntity;
      },
    );
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required RegisterRequestModel requestModel,
  }) async {
    return repoManager.call(
      action: () async {
        final userEntity = await loginDataSource.register(
          requestModel: requestModel,
        );
        await userInfoLocalDataSourceImpl.saveUserData(user: userEntity);
        return userEntity;
      },
    );
  }
}
