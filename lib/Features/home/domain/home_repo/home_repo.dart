import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/home/domain/entities/categories_entity/categories_entity.dart';

import '../../../../core/errors_manager/failure.dart';
import '../entities/products_entity/product_entity.dart';

abstract class HomeRepo {
  const HomeRepo();
  Future<Either<Failure, List<ProductEntity>>> fetchProducts();
  Future<Either<Failure, List<CategoriesEntity>>> fetchCategories();
}
