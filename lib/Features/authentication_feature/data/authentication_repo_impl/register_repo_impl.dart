import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/authentication_feature/data/authentication_data_source/register_data_source.dart';
import 'package:shop_app/Features/authentication_feature/data/authentication_models/login_model.dart';
import 'package:shop_app/core/errors/failure.dart';

import '../../domain/authentication_repo/register_repo/register_repo.dart';

class RegisterRepoImpl extends RegisterRepo {
  final RegisterDataSource registerDataSource;

  RegisterRepoImpl({required this.registerDataSource});

  @override
  Future<Either<Failure, LoginModel>> register(
      {required String email,
      required String password,
      required String name,
      required String phone}) async {
    try {
      final registerEntity = await registerDataSource.register(
          email: email, password: password, name: name, phone: phone);
      return Right(registerEntity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
