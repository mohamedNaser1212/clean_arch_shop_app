import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

abstract class SuperCartUseCase<T> {
  Future<Either<Failure, List<T>>> call([
    num products = 0,
  ]);
}
