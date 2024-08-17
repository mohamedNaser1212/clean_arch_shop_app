import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

abstract class SuperRegisterUseCase<Type> {
  Future<Either<Failure, Type>> call([email, password, name, phone]);
}
