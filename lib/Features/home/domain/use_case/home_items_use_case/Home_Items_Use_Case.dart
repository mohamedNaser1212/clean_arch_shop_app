import 'package:dartz/dartz.dart';
import 'package:shop_app/Features/home/domain/entities/categories_entity/categories_entity.dart';
import 'package:shop_app/Features/home/domain/use_case/home_items_use_case/super_home_items_use_case.dart';

import '../../../../../core/errors/failure.dart';
import '../../entities/products_entity/product_entity.dart';
import '../../home_repo/home_repo.dart';

class HomeItemsUseCase extends SuperHomeItemsUseCase<ProductEntity> {
  final HomeRepo homeRepo;
  HomeItemsUseCase(this.homeRepo);

  @override
  Future<Either<Failure, List<ProductEntity>>> productsCall() {
    return homeRepo.fetchProducts();
  }

  @override
  Future<Either<Failure, List<CategoriesEntity>>> categoriesCall() {
    return homeRepo.fetchCategories();
  }
}
