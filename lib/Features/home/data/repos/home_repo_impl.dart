import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shop_app/core/errors/failure.dart';

import '../../../../core/models/hive_manager/hive_manager.dart';
import '../../../../core/utils/screens/widgets/end_points.dart';
import '../../domain/entities/categories_entity/categories_entity.dart';
import '../../domain/entities/products_entity/product_entity.dart';
import '../../domain/home_repo/home_repo.dart';
import '../data_sources/home_remote_data_sources/home_remote_data_source.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepoImpl({
    required this.homeRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<CategoriesEntity>>> fetchCategories() async {
    try {
      //  Check if categories are cached
      final cachedCategories =
          await HiveManager.loadData<CategoriesEntity>(kCategoriesBox);
      if (cachedCategories.isNotEmpty) {
        return right(cachedCategories);
      }

      // Fetch from remote if not cached
      final categoriesList = await homeRemoteDataSource.fetchCategories();
      await HiveManager.saveData<CategoriesEntity>(
          categoriesList, kCategoriesBox);

      return right(categoriesList);
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> fetchProducts() async {
    try {
      final cachedProducts =
          await HiveManager.loadData<ProductEntity>(kProductsBox);
      if (cachedProducts.isNotEmpty) {
        return right(cachedProducts);
      }

      // Fetch from remote if not cached
      final productsList = await homeRemoteDataSource.fetchFeaturedProducts();
      await HiveManager.saveData<ProductEntity>(productsList, kProductsBox);

      return right(productsList);
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
