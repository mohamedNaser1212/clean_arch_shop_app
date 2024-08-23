import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../../core/errors_manager/failure.dart';
import '../../../../../core/networks/api_manager/api_service_interface.dart';
import '../../get_user_repo/get_user_repo.dart';

class UserSignOutUseCase {
  final UserDataRepo getUserDataRepo;

  const UserSignOutUseCase({
    required this.getUserDataRepo,
  });

  Future<Either<Failure, bool>> call({
    required BuildContext context,
    required ApiHelper apiService,
  }) async {
    return await getUserDataRepo.signOut(
      context: context,
      apiService: apiService,
    );
  }
}
