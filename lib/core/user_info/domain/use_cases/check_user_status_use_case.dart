import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/core/errors_manager/failure.dart';
import 'package:shop_app/core/user_info/domain/user_info_repo/user_info_repo.dart';

import '../../../networks/api_manager/api_helper.dart';

class CheckUserStatusUseCase {
  final UserInfoRepo userRepo;

  CheckUserStatusUseCase({
    required this.userRepo,
  });

  Future<Either<Failure, bool>> call({
    required ApiHelper apiService,
    required BuildContext context,
  }) async {
    return await userRepo.checkUserStatus(
        apiService: apiService, context: context);
  }
}
