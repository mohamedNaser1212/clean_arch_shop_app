import 'package:dartz/dartz.dart';
import 'package:shop_app/core/errors/failure.dart';

import '../../../../../models/login_model.dart';

abstract class SuperGetUserDataRepo {
  Future<Either<Failure, LoginModel>> getUserData();
  Future<Either<Failure, LoginModel>> UpdateUserData({
    required String name,
    required String email,
    required String phone,
  });
}
