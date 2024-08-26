import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../errors_manager/failure.dart';
import '../../../networks/api_manager/api_helper.dart';

abstract class UserInfoRepo {
  const UserInfoRepo();

  Future<Either<Failure, String?>> getUserToken();
  Future<Either<Failure, void>> saveToken({
    required String token,
  });
  Future<Either<Failure, bool>> checkUserStatus({
    required BuildContext context,
    required ApiHelper apiService,
  });
}
