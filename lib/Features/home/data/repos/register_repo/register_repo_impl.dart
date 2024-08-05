import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/home/data/repos/register_repo/register_repo.dart';
import 'package:shop_app/core/errors/failure.dart';
import 'package:shop_app/models/login_model.dart';

import '../../data_sorces/remote_data_sources/register_data_source.dart';

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
      final registerEntity = await registerDataSource.Register(
          email: email, password: password, name: name, phone: phone);
      return Right(registerEntity);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
