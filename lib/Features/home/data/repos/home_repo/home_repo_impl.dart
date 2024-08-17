import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shop_app/Features/home/data/repos/home_repo/home_repo.dart';
import 'package:shop_app/Features/home/domain/entities/categories_entity/categories_entity.dart';
import 'package:shop_app/core/errors/failure.dart';

import '../../../domain/entities/products_entity/product_entity.dart';
import '../../data_sorces/local_data_sources/home_local_data_source.dart';
import '../../data_sorces/remote_data_sources/home_remote_data_source.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeLocalDataSource homeLocalDataSource;

  HomeRepoImpl({
    required this.homeRemoteDataSource,
    required this.homeLocalDataSource,
  });

  @override
  Future<Either<Failure, List<CategoriesEntity>>> fetchCategories() async {
    List<CategoriesEntity> categoriesList;
    try {
      categoriesList = await homeRemoteDataSource.fetchCategories();
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
    List<ProductEntity> productsList;
    try {
      productsList = await homeRemoteDataSource.fetchFeaturedProducts();
      return right(productsList);
    } catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
