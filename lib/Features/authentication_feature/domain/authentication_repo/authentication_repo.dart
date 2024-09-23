import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/authentication_feature/data/model/login_request_model.dart';
import 'package:shop_app/Features/authentication_feature/data/model/register_request_model.dart';

import '../../../../core/managers/errors_manager/failure.dart';
import '../../../settings_feature/domain/user_entity/user_entity.dart';

abstract class AuthenticationRepo {
  const AuthenticationRepo();
  Future<Either<Failure, UserEntity>> login({
    required LoginRequestModel requestModel,
  });
  Future<Either<Failure, UserEntity>> register({
    required RegisterRequestModel requestModel,
  });
}
