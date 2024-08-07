import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

abstract class SuperAddToCartUseCase<T> {
  Future<Either<Failure, List<T>>> call();
}
