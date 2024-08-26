import 'package:dartz/dartz.dart';
import 'package:shop_app/core/errors_manager/failure.dart';
import 'package:shop_app/core/user_info/domain/user_info_repo/user_info_repo.dart';

class GetTokenUseCase {
  final UserInfoRepo userInfoRepo;

  GetTokenUseCase({
    required this.userInfoRepo,
  });

  Future<Either<Failure, String?>> call() async {
    return await userInfoRepo.getUserToken();
  }
}
