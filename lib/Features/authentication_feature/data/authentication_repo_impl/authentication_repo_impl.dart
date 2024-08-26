import 'package:dartz/dartz.dart';
import 'package:shop_app/core/user_info/data/user_info_data_sources/user_info_local_data_source.dart';

import '../../../../core/errors_manager/failure.dart';
import '../../../settings_feature/domain/user_entity/user_entity.dart';
import '../../domain/authentication_repo/authentication_repo.dart';
import '../authentication_data_sources/authentication_remote_data_source.dart';

class AuthRepoImpl implements AuthenticationRepo {
  final AuthenticationRemoteDataSource loginDataSource;
  final UserInfoLocalDataSource userInfoLocalDataSourceImpl;

  const AuthRepoImpl({
    required this.loginDataSource,
    required this.userInfoLocalDataSourceImpl,
  });

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response =
          await loginDataSource.login(email: email, password: password);
      await userInfoLocalDataSourceImpl.saveUserData(user: response);
      print('Token from login is : ${response.token}');
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      final registerEntity = await loginDataSource.register(
          email: email, password: password, name: name, phone: phone);
      await userInfoLocalDataSourceImpl.saveUserData(user: registerEntity);
      return Right(registerEntity);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
