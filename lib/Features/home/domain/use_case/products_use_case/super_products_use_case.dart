import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

abstract class ProductsUseCase<T> {
  Future<Either<Failure, List<T>>> call();
}
