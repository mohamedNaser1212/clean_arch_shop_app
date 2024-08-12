import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/home/domain/entities/user_entity/user_entity.dart';
import 'package:shop_app/core/errors/failure.dart';

abstract class SuperGetUserDataRepo {
  Future<Either<Failure, UserEntity>> getUserData();
  Future<Either<Failure, UserEntity>> UpdateUserData({
    required String name,
    required String email,
    required String phone,
  });
}
