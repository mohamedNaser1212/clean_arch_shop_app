import 'package:dartz/dartz.dart';
import 'package:shop_app/core/errors/failure.dart';

import '../../../../settings_feature/domain/get_user_repo/get_user_repo.dart';
import '../../../../settings_feature/domain/user_entity/user_entity.dart';

class UserDataUseCase {
  final UserDataRepo getUserDataRepo;

  UserDataUseCase({required this.getUserDataRepo});

  Future<Either<Failure, UserEntity>> getUserData() async {
    return await getUserDataRepo.getUserData();
  }
}
