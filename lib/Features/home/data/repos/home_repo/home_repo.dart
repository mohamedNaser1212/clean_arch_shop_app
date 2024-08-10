import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/home/domain/entities/categories_entity/categories_entity.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../models/new_get_home_data.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<Products>>> fetchProducts();
  Future<Either<Failure, List<CategoriesEntity>>> fetchCategories();
}
