import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/authentication_feature/data/authentication_models/authentication_model.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/authentication_repo/authentication_repo.dart';
import '../authentication_data_source/authentication_data_source.dart';

class AuthRepoImpl implements AuthenticationRepo {
  final LoginDataSource loginDataSource;

  AuthRepoImpl({required this.loginDataSource});

  @override
  Future<Either<Failure, AuthenticationModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response =
          await loginDataSource.login(email: email, password: password);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthenticationModel>> register(
      {required String email,
      required String password,
      required String name,
      required String phone}) async {
    try {
      final registerEntity = await loginDataSource.register(
          email: email, password: password, name: name, phone: phone);
      return Right(registerEntity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
