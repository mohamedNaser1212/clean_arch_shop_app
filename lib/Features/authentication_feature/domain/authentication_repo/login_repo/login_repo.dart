import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../authentication_feature/data/authentication_models/login_model.dart';

abstract class LoginRepo {
  Future<Either<Failure, LoginModel>> login(
      {required String email, required String password});
}
