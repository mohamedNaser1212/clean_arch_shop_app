import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

abstract class SuperGetUserDataUseCase<Type> {
  Future<Either<Failure, Type>> GetUserData();
  Future<Either<Failure, Type>> UpdateUserData({
    required String name,
    required String email,
    required String phone,
  });
}
