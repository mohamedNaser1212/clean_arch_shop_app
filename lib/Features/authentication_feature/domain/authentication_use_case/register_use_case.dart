import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/authentication_feature/domain/authentication_repo/authentication_repo.dart';

import '../../../../core/errors_manager/failure.dart';
import '../../../settings_feature/domain/user_entity/user_entity.dart';

class RegisterUseCase {
  final AuthenticationRepo authenticationRepo;

  const RegisterUseCase({required this.authenticationRepo});

  Future<Either<Failure, UserEntity>> call({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    return await authenticationRepo.register(
        email: email, password: password, name: name, phone: phone);
  }
}
