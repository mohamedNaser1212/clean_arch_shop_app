import 'package:dartz/dartz.dart';
import 'package:shop_app/models/categories_model.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../models/home_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<ProductModel>>> fetchProducts();
  Future<Either<Failure, List<DataModel>>> fetchCategories();
}
