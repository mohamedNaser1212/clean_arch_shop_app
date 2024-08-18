import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../entities/products_entity/product_entity.dart';
import '../../home_repo/home_repo.dart';

class productsUseCase {
  final HomeRepo homeRepo;
  productsUseCase(this.homeRepo);

  Future<Either<Failure, List<ProductEntity>>> productsCall() {
    return homeRepo.fetchProducts();
  }
}
