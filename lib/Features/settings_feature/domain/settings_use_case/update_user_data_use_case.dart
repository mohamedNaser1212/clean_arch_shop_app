import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/settings_feature/data/update_user_request_model.dart';

import '../../../../core/managers/errors_manager/failure.dart';
import '../get_user_repo/get_user_repo.dart';
import '../user_entity/user_entity.dart';

class UpdateUserDataUseCase {
  final UserDataRepo getUserDataRepo;

  const UpdateUserDataUseCase({
    required this.getUserDataRepo,
  });

  Future<Either<Failure, UserEntity>> call({
    required UpdateUserRequestModel updateUserRequestModel,
  }) {
    return getUserDataRepo.updateUserData(
      updateUserRequestModel: updateUserRequestModel,
    );
  }
}
