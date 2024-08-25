import 'package:dartz/dartz.dart';

import '../../../../core/errors_manager/failure.dart';
import '../get_user_repo/get_user_repo.dart';
import '../user_entity/user_entity.dart';

class UserDataUseCase {
  final UserDataRepo getUserDataRepo;

  const UserDataUseCase({required this.getUserDataRepo});

  Future<Either<Failure, UserEntity>> call() async {
    return await getUserDataRepo.getUserData();
  }
}
