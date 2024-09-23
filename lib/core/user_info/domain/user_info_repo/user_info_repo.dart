import 'package:dartz/dartz.dart';

import '../../../../Features/settings_feature/domain/user_entity/user_entity.dart';
import '../../../managers/errors_manager/failure.dart';

abstract class UserInfoRepo {
  const UserInfoRepo();

  Future<Either<Failure, UserEntity?>> getUser();
}
