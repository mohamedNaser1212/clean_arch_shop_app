import 'package:dartz/dartz.dart';

import '../../../../core/errors_manager/failure.dart';

abstract class AuthenticationLocalDataSource {
  Future<Either<Failure, void>> saveToken(String token);
  Future<Either<Failure, String>> getToken();
  Future<Either<Failure, void>> removeToken();
}
