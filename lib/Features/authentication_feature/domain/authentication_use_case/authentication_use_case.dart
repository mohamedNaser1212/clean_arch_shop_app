import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/authentication_feature/domain/authentication_use_case/super_authentication_use_case.dart';

import '../../../../../core/errors/failure.dart';
import '../../data/authentication_models/authentication_model.dart';
import '../authentication_repo/authentication_repo.dart';

class AuthenticationUseCase extends UseCase<AuthenticationModel> {
  final LoginRepo loginRepo;

  AuthenticationUseCase(this.loginRepo);

  @override
  Future<Either<Failure, AuthenticationModel>> call([email, password]) async {
    return await loginRepo.login(email: email, password: password);
  }

  @override
  Future<Either<Failure, AuthenticationModel>> callRegister(
      [email, password, name, phone]) async {
    return await loginRepo.register(
      email: email,
      password: password,
      name: name,
      phone: phone,
    );
  }
}
