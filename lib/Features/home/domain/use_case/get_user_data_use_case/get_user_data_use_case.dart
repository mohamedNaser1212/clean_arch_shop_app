import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/home/domain/use_case/get_user_data_use_case/super_get_user_data_use_case.dart';
import 'package:shop_app/core/errors/failure.dart';
import 'package:shop_app/models/login_model.dart';

import '../../../data/repos/get_user_repo/get_user_repo.dart';

class UserDataUseCase extends SuperGetUserDataUseCase<LoginModel> {
  final SuperGetUserDataRepo getUserDataRepo;

  UserDataUseCase({required this.getUserDataRepo});

  @override
  Future<Either<Failure, LoginModel>> GetUserData() async {
    return await getUserDataRepo.getUserData();
  }

  @override
  Future<Either<Failure, LoginModel>> UpdateUserData(
      {required String name, required String email, required String phone}) {
    return getUserDataRepo.UpdateUserData(
        name: name, email: email, phone: phone);
  }
}
