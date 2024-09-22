import 'package:dartz/dartz.dart';
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
    required String email,
    required String password,
  }) async {
    return repoManager.call(
      action: () async {
        final userEntity =
            await loginDataSource.login(email: email, password: password);
        await userInfoLocalDataSourceImpl.saveUserData(user: userEntity);
        return userEntity;
      },
    );
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    return repoManager.call(
      action: () async {
        final userEntity = await loginDataSource.register(
          email: email,
          password: password,
          name: name,
          phone: phone,
        );
        await userInfoLocalDataSourceImpl.saveUserData(user: userEntity);
        return userEntity;
      },
    );
  }
}
