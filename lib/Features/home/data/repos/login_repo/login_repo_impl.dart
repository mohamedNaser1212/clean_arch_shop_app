import 'package:dartz/dartz.dart';
import 'package:shop_app/models/login_model.dart';

import '../../../../../core/errors/failure.dart';
import '../../data_sorces/remote_data_sources/login_data_source.dart';
import 'login_repo.dart';

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
