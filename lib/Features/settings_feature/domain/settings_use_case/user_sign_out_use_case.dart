import 'package:dartz/dartz.dart';

import '../../../../../core/errors_manager/failure.dart';
import '../../../../../core/networks/api_manager/api_manager.dart';
import '../get_user_repo/get_user_repo.dart';

class UserSignOutUseCase {
  final UserDataRepo getUserDataRepo;

  const UserSignOutUseCase({
    required this.getUserDataRepo,
  });

  Future<Either<Failure, bool>> call({
    required ApiManager apiService,
  }) async {
    return await getUserDataRepo.signOut(
      apiService: apiService,
    );
  }
}
