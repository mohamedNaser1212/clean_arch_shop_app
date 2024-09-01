import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shop_app/core/initial_screen/manager/internet_manager/internet_manager.dart';

import '../../../../core/errors_manager/failure.dart';
import '../../../../core/errors_manager/internet_failure.dart';
import '../../domain/entities/categories_entity/categories_entity.dart';
import '../../domain/entities/products_entity/product_entity.dart';
import '../../domain/home_repo/home_repo.dart';
import '../data_sources/home_local_data_source/home_local_data_source.dart';
import '../data_sources/home_remote_data_sources/home_remote_data_source.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeRemoteDataSource homeRemoteDataSource;
  final HomeLocalDataSource homeLocalDataSource;
  final InternetManager internetManager;

  const HomeRepoImpl({
    required this.homeRemoteDataSource,
    required this.homeLocalDataSource,
    required this.internetManager,
  });

  @override
  Future<Either<Failure, List<CategoriesEntity>>> fetchCategories() async {
    try {
      final isConnected = await internetManager.checkConnection();
      if (!isConnected) {
        return left(
          InternetFailure.fromConnectionStatus(
              InternetConnectionStatus.disconnected),
        );
      } else {
        final cachedCategories = await homeLocalDataSource.getCategories();
        if (cachedCategories.isNotEmpty) {
          return right(cachedCategories);
        }
      }

      final categoriesList = await homeRemoteDataSource.fetchCategories();
      await homeLocalDataSource.saveCategories(categoriesList);

      return right(categoriesList);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> fetchProducts() async {
    try {
      final isConnected = await internetManager.checkConnection();
      if (!isConnected) {
        return left(
          InternetFailure.fromConnectionStatus(
              InternetConnectionStatus.disconnected),
        );
      } else {
        final cachedProducts = await homeLocalDataSource.getProducts();
        if (cachedProducts.isNotEmpty) {
          return right(cachedProducts);
        }
      }

      final productsList = await homeRemoteDataSource.fetchProducts();
      await homeLocalDataSource.saveProducts(productsList);

      return right(productsList);
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
