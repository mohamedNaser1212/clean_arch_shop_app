import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

abstract class SuperFavouritesUseCase<T> {
  Future<Either<Failure, List<T>>> call();
  Future<Either<Failure, bool>> toggleFavouriteCall(num productIds);
}
