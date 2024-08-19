import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

abstract class UserDataUseCase<Type> {
  Future<Either<Failure, Type>> getUserData();
  Future<Either<Failure, Type>> updateUserData({
    required String name,
    required String email,
    required String phone,
  });
}
