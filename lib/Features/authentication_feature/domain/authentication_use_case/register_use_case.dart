import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/authentication_feature/domain/authentication_repo/authentication_repo.dart';

import '../../../../core/errors/failure.dart';
import '../../data/authentication_models/authentication_model.dart';

class RegisterUseCase {
  final AuthenticationRepo authenticationRepo;

  RegisterUseCase(this.authenticationRepo);

  Future<Either<Failure, AuthenticationModel>> call(
      [email, password, phone, name]) async {
    return await authenticationRepo.register(
        email: email, password: password, name: name, phone: phone);
  }
}
