import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

abstract class FavouritesUseCase<T> {
  Future<Either<Failure, List<T>>> call();
}
