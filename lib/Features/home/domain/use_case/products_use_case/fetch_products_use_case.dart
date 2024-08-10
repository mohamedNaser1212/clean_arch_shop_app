import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/home/domain/use_case/products_use_case/super_products_use_case.dart';
import 'package:shop_app/models/new_get_home_data.dart';

import '../../../../../core/errors/failure.dart';
import '../../../data/repos/home_repo/home_repo.dart';

class FetchProductsUseCase extends ProductsUseCase<Products> {
  final HomeRepo homeRepo;
  FetchProductsUseCase(this.homeRepo);

  @override
  Future<Either<Failure, List<Products>>> call() {
    return homeRepo.fetchProducts();
  }
}
