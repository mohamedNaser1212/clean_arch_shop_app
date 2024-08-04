import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../models/login_model.dart';

abstract class RegisterRepo {
  Future<Either<Failure, LoginModel>> register({
    required String email,
    required String password,
    required String name,
    required String phone,
  });
}
