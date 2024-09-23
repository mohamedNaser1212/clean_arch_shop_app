import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/settings_feature/domain/user_entity/user_entity.dart';
import 'package:shop_app/core/user_info/domain/user_info_repo/user_info_repo.dart';

import '../../../managers/errors_manager/failure.dart';

class GetUserInfoUseCase {
  final UserInfoRepo userInfoRepo;

  const GetUserInfoUseCase({
    required this.userInfoRepo,
  });

  Future<Either<Failure, UserEntity?>> call() async {
    return await userInfoRepo.getUser();
  }
}
