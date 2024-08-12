import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/home/domain/use_case/get_user_data_use_case/super_get_user_data_use_case.dart';
import 'package:shop_app/core/errors/failure.dart';

import '../../../data/repos/get_user_repo/get_user_repo.dart';
import '../../entities/user_entity/user_entity.dart';

class UserDataUseCase extends SuperGetUserDataUseCase<UserEntity> {
  final SuperGetUserDataRepo getUserDataRepo;

  UserDataUseCase({required this.getUserDataRepo});

  @override
  Future<Either<Failure, UserEntity>> GetUserData() async {
    return await getUserDataRepo.getUserData();
  }

  @override
  Future<Either<Failure, UserEntity>> UpdateUserData(
      {required String name, required String email, required String phone}) {
    return getUserDataRepo.UpdateUserData(
        name: name, email: email, phone: phone);
  }
}
