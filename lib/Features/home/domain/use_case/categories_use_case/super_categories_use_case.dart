import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';

abstract class CategoriesUseCase<Type> {
  Future<Either<Failure, List<Type>>> call();
}
