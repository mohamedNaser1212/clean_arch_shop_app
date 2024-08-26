import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/authentication_feature/domain/authentication_repo/authentication_repo.dart';

import '../../../../core/errors_manager/failure.dart';
import '../../../settings_feature/domain/user_entity/user_entity.dart';

class LoginUseCase {
  final AuthenticationRepo authenticationRepo;

  const LoginUseCase({required this.authenticationRepo});

  Future<Either<Failure, UserEntity>> call({
    required String email,
    required String password,
  }) async {
    return await authenticationRepo.login(email: email, password: password);
  }
}
