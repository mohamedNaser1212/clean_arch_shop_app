import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shop_app/core/errors/failure.dart';

import '../../domain/entities/categories_entity/categories_entity.dart';
import '../../domain/entities/products_entity/product_entity.dart';
import '../../domain/home_repo/home_repo.dart';
import '../data_sources/home_local_data_source/home_local_data_source.dart';
import '../data_sources/home_remote_data_sources/home_remote_data_source.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeLocalDataSource homeLocalDataSource;

  const HomeRepoImpl({
    required this.homeRemoteDataSource,
    required this.homeLocalDataSource,
  });

  @override
  Future<Either<Failure, List<CategoriesEntity>>> fetchCategories() async {
    try {
      final cachedCategories = await homeLocalDataSource.getCategories();
      if (cachedCategories.isRight() &&
          cachedCategories.getOrElse(() => []).isNotEmpty) {
        return right(cachedCategories.getOrElse(() => []));
      }

      final categoriesList = await homeRemoteDataSource.fetchCategories();
      await homeLocalDataSource.saveCategories(categoriesList);

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
      final cachedProducts = await homeLocalDataSource.getProducts();
      if (cachedProducts.isRight() &&
          cachedProducts.getOrElse(() => []).isNotEmpty) {
        return right(cachedProducts.getOrElse(() => []));
      }

      final productsList = await homeRemoteDataSource.fetchFeaturedProducts();
      await homeLocalDataSource.saveProducts(productsList);

      return right(productsList);
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
