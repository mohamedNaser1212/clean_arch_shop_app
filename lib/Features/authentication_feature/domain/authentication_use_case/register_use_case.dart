import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/authentication_feature/data/model/register_request_model.dart';
import 'package:shop_app/Features/authentication_feature/domain/authentication_repo/authentication_repo.dart';

import '../../../../core/managers/errors_manager/failure.dart';
import '../../../settings_feature/domain/user_entity/user_entity.dart';

class RegisterUseCase {
  final AuthenticationRepo authenticationRepo;

  const RegisterUseCase({
    required this.authenticationRepo,
  });

  Future<Either<Failure, UserEntity>> call({
    required RegisterRequestModel requestModel,
  }) async {
    return await authenticationRepo.register(
      requestModel: requestModel,
    );
  }
}
