import 'package:dartz/dartz.dart';

import '../../../../core/managers/errors_manager/failure.dart';
import '../get_user_repo/get_user_repo.dart';

class UserSignOutUseCase {
  final UserDataRepo getUserDataRepo;

  const UserSignOutUseCase({
    required this.getUserDataRepo,
  });

  Future<Either<Failure, bool>> call() async {
    return await getUserDataRepo.signOut();
  }
}
