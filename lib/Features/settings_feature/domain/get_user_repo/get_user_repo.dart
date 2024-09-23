import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/settings_feature/data/update_user_request_model.dart';

import '../../../../core/errors_manager/failure.dart';
import '../user_entity/user_entity.dart';

abstract class UserDataRepo {
  const UserDataRepo();
  Future<Either<Failure, UserEntity>> getUserData();
  Future<Either<Failure, UserEntity>> updateUserData({
       required UpdateUserRequestModel updateUserRequestModel,

  });

  Future<Either<Failure, bool>> signOut();
}
