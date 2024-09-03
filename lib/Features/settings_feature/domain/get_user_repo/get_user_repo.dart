import 'package:dartz/dartz.dart';

import '../../../../core/errors_manager/failure.dart';
import '../user_entity/user_entity.dart';

abstract class UserDataRepo {
  const UserDataRepo();
  Future<Either<Failure, UserEntity>> getUserData();
  Future<Either<Failure, UserEntity>> updateUserData({
    required String name,
    required String email,
    required String phone,
  });

  Future<Either<Failure, bool>> signOut();
}
