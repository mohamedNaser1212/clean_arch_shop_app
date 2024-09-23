import 'package:dartz/dartz.dart';

import '../../../../../core/managers/errors_manager/failure.dart';
import '../../entities/products_entity/product_entity.dart';
import '../../home_repo/home_repo.dart';

class ProductsUseCase {
  final HomeRepo homeRepo;
  const ProductsUseCase({
    required this.homeRepo,
  });

  Future<Either<Failure, List<ProductEntity>>> call() {
    return homeRepo.fetchProducts();
  }
}
