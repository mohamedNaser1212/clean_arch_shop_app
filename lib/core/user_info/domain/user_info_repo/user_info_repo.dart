import 'package:dartz/dartz.dart';

import '../../../../features/settings_feature/domain/user_entity/user_entity.dart';
import '../../../errors_manager/failure.dart';

abstract class UserInfoRepo {
  const UserInfoRepo();

  Future<Either<Failure, UserEntity?>> getUser();
}
