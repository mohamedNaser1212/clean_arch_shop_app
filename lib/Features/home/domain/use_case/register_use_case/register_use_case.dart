import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/home/data/repos/register_repo/register_repo.dart';
import 'package:shop_app/Features/home/domain/use_case/register_use_case/super_register_use_case.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../models/login_model.dart';

class RegisterUseCase extends SuperRegisterUseCase<LoginModel> {
  final RegisterRepo registerRepo;

  RegisterUseCase(this.registerRepo);

  @override
  Future<Either<Failure, LoginModel>> call(
      [email, password, name, phone]) async {
    return await registerRepo.register(
      email: email,
      password: password,
      name: name,
      phone: phone,
    );
  }
}
