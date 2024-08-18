import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

abstract class SuperCartUseCase<T> {
  Future<Either<Failure, List<T>>> call([
    num products = 0,
  ]);

  Future<Either<Failure, List<T>>> removeFromCartCall([
    num products = 0,
  ]);

  Future<Either<Failure, bool>> toggleCartCall(num products);
}
