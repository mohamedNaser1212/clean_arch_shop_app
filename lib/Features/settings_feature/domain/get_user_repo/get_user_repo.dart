import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/errors_manager/failure.dart';
import '../../../../core/networks/api_manager/api_service_interface.dart';
import '../user_entity/user_entity.dart';

abstract class UserDataRepo {
  Future<Either<Failure, UserEntity>> getUserData();
  Future<Either<Failure, UserEntity>> updateUserData({
    required String name,
    required String email,
    required String phone,
  });

  Future<Either<Failure, bool>> signOut({
    required BuildContext context,
    required ApiHelper apiService,
  });
}
