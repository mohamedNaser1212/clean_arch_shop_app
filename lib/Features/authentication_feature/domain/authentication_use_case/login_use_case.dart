import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/authentication_feature/domain/authentication_repo/authentication_repo.dart';
import 'package:shop_app/core/errors/failure.dart';

import '../../data/authentication_models/authentication_model.dart';

class LoginUseCase {
  final AuthenticationRepo authenticationRepo;

  LoginUseCase(this.authenticationRepo);

  Future<Either<Failure, AuthenticationModel>> call({
    required String email,
    required String password,
  }) async {
    return await authenticationRepo.login(email: email, password: password);
  }
}
