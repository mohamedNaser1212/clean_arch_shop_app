import 'package:dartz/dartz.dart';
import 'package:shop_app/core/errors/failure.dart';

import '../../../../settings_feature/domain/get_user_repo/get_user_repo.dart';
import '../../../../settings_feature/domain/user_entity/user_entity.dart';

class GetUserDataUseCase {
  final SuperGetUserDataRepo getUserDataRepo;

  GetUserDataUseCase({required this.getUserDataRepo});

  Future<Either<Failure, UserEntity>> GetUserData() async {
    return await getUserDataRepo.getUserData();
  }
}
