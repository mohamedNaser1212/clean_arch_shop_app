import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../get_user_repo/get_user_repo.dart';
import '../../user_entity/user_entity.dart';

class UpdateUserDataUseCase {
  final UserDataRepo getUserDataRepo;

  UpdateUserDataUseCase(this.getUserDataRepo);

  Future<Either<Failure, UserEntity>> UpdateUserData(
      {required String name, required String email, required String phone}) {
    return getUserDataRepo.UpdateUserData(
        name: name, email: email, phone: phone);
  }
}
