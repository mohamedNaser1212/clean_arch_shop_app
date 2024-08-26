import 'package:dartz/dartz.dart';

import '../../../errors_manager/failure.dart';
import '../user_info_repo/user_info_repo.dart';

class SaveTokenUseCase {
  final UserInfoRepo _userInfoRepo;

  SaveTokenUseCase(this._userInfoRepo);

  Future<Either<Failure, void>> call({
    required String token,
  }) async {
    return _userInfoRepo.saveToken(token: token);
  }
}
