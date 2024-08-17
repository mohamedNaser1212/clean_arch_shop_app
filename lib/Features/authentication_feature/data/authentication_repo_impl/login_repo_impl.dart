import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/authentication_feature/data/authentication_models/login_model.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/authentication_repo/login_repo/login_repo.dart';
import '../authentication_data_source/login_data_source.dart';

class LoginRepoImpl implements LoginRepo {
  final LoginDataSource loginDataSource;

  LoginRepoImpl({required this.loginDataSource});

  @override
  Future<Either<Failure, LoginModel>> login({
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
}
