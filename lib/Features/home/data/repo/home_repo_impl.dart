import 'package:dartz/dartz.dart';
import 'package:shop_app/core/managers/repo_manager/repo_manager.dart';

import '../../../../core/errors_manager/failure.dart';
import '../../domain/entities/categories_entity/categories_entity.dart';
import '../../domain/entities/products_entity/product_entity.dart';
import '../../domain/home_repo/home_repo.dart';
import '../data_sources/home_local_data_source/home_local_data_source.dart';
import '../data_sources/home_remote_data_sources/home_remote_data_source.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeLocalDataSource homeLocalDataSource;
  final RepoManager repoManager;

  const HomeRepoImpl({
    required this.homeRemoteDataSource,
    required this.homeLocalDataSource,
    required this.repoManager,
  });

  @override
  Future<Either<Failure, List<CategoriesEntity>>> fetchCategories() async {
    return repoManager.call(
      action: () async {
        final cachedCategories = await homeLocalDataSource.getCategories();
        if (cachedCategories.isNotEmpty) {
          return cachedCategories;
        } else {
          final categoriesList = await homeRemoteDataSource.fetchCategories();
          await homeLocalDataSource.saveCategories(categories: categoriesList);
          return categoriesList;
        }
      },
    );
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> fetchProducts() async {
    return repoManager.call(
      action: () async {
        final cachedProducts = await homeLocalDataSource.getProducts();
        if (cachedProducts.isNotEmpty) {
          return cachedProducts;
        } else {
          final productsList = await homeRemoteDataSource.fetchProducts();
          await homeLocalDataSource.saveProducts(products: productsList);
          return productsList;
        }
      },
    );
  }
}
