import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/home/domain/use_case/login_use_case/super_login_use_case.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../models/login_model.dart';
import '../../../data/repos/login_repo/login_repo.dart';

class LoginUseCase extends UseCase<LoginModel> {
  final LoginRepo loginRepo;

  LoginUseCase(this.loginRepo);

  @override
  Future<Either<Failure, LoginModel>> call([email, password]) async {
    return await loginRepo.login(email: email, password: password);
  }
}
