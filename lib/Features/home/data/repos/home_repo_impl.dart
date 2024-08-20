import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shop_app/core/errors/failure.dart';
import 'package:shop_app/core/models/hive_manager/hive_service.dart';

import '../../../../core/utils/hive_boxes_names/hive_boxes_names.dart';
import '../../domain/entities/categories_entity/categories_entity.dart';
import '../../domain/entities/products_entity/product_entity.dart';
import '../../domain/home_repo/home_repo.dart';
import '../data_sources/home_remote_data_sources/home_remote_data_source.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;
  final HiveService hiveService;

  HomeRepoImpl({
    required this.homeRemoteDataSource,
    required this.hiveService,
  });

  @override
  Future<Either<Failure, List<CategoriesEntity>>> fetchCategories() async {
    try {
      final cachedCategories = await hiveService
          .loadData<CategoriesEntity>(HiveBoxesNames.kCategoriesBox);
      if (cachedCategories.isNotEmpty) {
        return right(cachedCategories);
      }

      // Fetch from remote if not cached
      final categoriesList = await homeRemoteDataSource.fetchCategories();
      await hiveService.saveData<CategoriesEntity>(
          categoriesList, HiveBoxesNames.kCategoriesBox);

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
      final cachedProducts = await hiveService
          .loadData<ProductEntity>(HiveBoxesNames.kProductsBox);
      if (cachedProducts.isNotEmpty) {
        return right(cachedProducts);
      }

      final productsList = await homeRemoteDataSource.fetchFeaturedProducts();
      await hiveService.saveData<ProductEntity>(
          productsList, HiveBoxesNames.kProductsBox);

      return right(productsList);
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
