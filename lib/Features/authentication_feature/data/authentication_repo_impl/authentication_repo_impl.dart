import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/authentication_feature/data/authentication_models/authentication_model.dart';

import '../../../../core/errors_manager/failure.dart';
import '../../../../core/user_info/data/user_info_data_sources/user_info_local_data_source.dart';
import '../../domain/authentication_repo/authentication_repo.dart';
import '../authentication_data_sources/authentication_remote_data_source.dart';

class AuthRepoImpl implements AuthenticationRepo {
  final AuthenticationRemoteDataSource loginDataSource;
  final UserInfoLocalDataSourceImpl userInfoLocalDataSourceImpl;

  const AuthRepoImpl({
    required this.loginDataSource,
    required this.userInfoLocalDataSourceImpl,
  });

  @override
  Future<Either<Failure, AuthenticationModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response =
          await loginDataSource.login(email: email, password: password);
      await userInfoLocalDataSourceImpl.saveToken(token: response.token);
      print('Token from login is : ${response.token}');
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthenticationModel>> register({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      final registerEntity = await loginDataSource.register(
          email: email, password: password, name: name, phone: phone);
      await userInfoLocalDataSourceImpl.saveToken(token: registerEntity.token);
      return Right(registerEntity);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
