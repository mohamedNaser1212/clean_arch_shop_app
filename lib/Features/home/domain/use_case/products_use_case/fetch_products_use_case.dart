import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/home/domain/use_case/products_use_case/super_products_use_case.dart';
import 'package:shop_app/models/home_model.dart';

import '../../../../../core/errors/failure.dart';
import '../../../data/repos/home_repo/home_repo.dart';

class FetchProductsUseCase extends ProductsUseCase<ProductModel> {
  final HomeRepo homeRepo;
  FetchProductsUseCase(this.homeRepo);

  @override
  Future<Either<Failure, List<ProductModel>>> call() {
    return homeRepo.fetchProducts();
  }
}
