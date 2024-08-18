import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../data/authentication_models/authentication_model.dart';

abstract class LoginRepo {
  Future<Either<Failure, AuthenticationModel>> login(
      {required String email, required String password});
  Future<Either<Failure, AuthenticationModel>> register({
    required String email,
    required String password,
    required String name,
    required String phone,
  });
}
