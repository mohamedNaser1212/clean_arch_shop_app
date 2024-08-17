import 'package:dartz/dartz.dart';
import 'package:shop_app/core/errors/failure.dart';

import '../../domain/get_user_repo/get_user_repo.dart';
import '../../domain/user_entity/user_entity.dart';
import '../user_info_data_source/user_info_data_source.dart';

class GetUserDataRepoImpl implements SuperGetUserDataRepo {
  final GetUserDataDataSource getUserDataDataSource;

  GetUserDataRepoImpl({required this.getUserDataDataSource});

  @override
  Future<Either<Failure, UserEntity>> getUserData() async {
    try {
      final userData = await getUserDataDataSource.getUserData();
      return Right(userData);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> UpdateUserData({
    required String name,
    required String email,
    required String phone,
  }) async {
    try {
      final userData = await getUserDataDataSource.updateUserData(
          name: name, email: email, phone: phone);
      return Right(userData);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }
}
