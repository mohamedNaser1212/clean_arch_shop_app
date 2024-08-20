import 'package:dartz/dartz.dart';
import 'package:shop_app/core/errors/failure.dart';

import '../../domain/get_user_repo/get_user_repo.dart';
import '../../domain/user_entity/user_entity.dart';
import '../user_data_data_source/save_user_data.dart';
import '../user_data_data_source/user_info_remote_data_source.dart';

class UserDataRepoImpl implements UserDataRepo {
  final UserDataSource getUserDataDataSource;

  UserDataRepoImpl({required this.getUserDataDataSource});

  @override
  Future<Either<Failure, UserEntity>> getUserData() async {
    try {
      final cachedUserData = await loadUserData();

      if (cachedUserData != null) {
        return Right(cachedUserData);
      } else {
        final userData = await getUserDataDataSource.getUserData();
        saveUserData(user: userData);
        return Right(userData);
      }
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
      saveUserData(user: userData);
      return Right(userData);
    } catch (error) {
      return Left(ServerFailure(error.toString()));
    }
  }
}
