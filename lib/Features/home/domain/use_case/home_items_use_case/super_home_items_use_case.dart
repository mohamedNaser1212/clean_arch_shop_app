import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../entities/categories_entity/categories_entity.dart';

abstract class SuperHomeItemsUseCase<T> {
  Future<Either<Failure, List<T>>> productsCall();
  Future<Either<Failure, List<CategoriesEntity>>> categoriesCall();
}
