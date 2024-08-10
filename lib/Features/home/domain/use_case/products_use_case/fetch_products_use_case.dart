import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/home/domain/use_case/products_use_case/super_products_use_case.dart';

import '../../../../../core/errors/failure.dart';
import '../../../data/repos/home_repo/home_repo.dart';
import '../../entities/products_entity/product_entity.dart';

class FetchProductsUseCase extends ProductsUseCase<ProductEntity> {
  final HomeRepo homeRepo;
  FetchProductsUseCase(this.homeRepo);

  @override
  Future<Either<Failure, List<ProductEntity>>> call() {
    return homeRepo.fetchProducts();
  }
}
