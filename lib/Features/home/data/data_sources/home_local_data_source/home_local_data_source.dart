import 'package:dartz/dartz.dart';

import '../../../../../core/errors_manager/failure.dart';
import '../../../../../core/networks/Hive_manager/hive_boxes_names.dart';
import '../../../../../core/networks/Hive_manager/hive_service.dart';
import '../../../domain/entities/categories_entity/categories_entity.dart';
import '../../../domain/entities/products_entity/product_entity.dart';

abstract class HomeLocalDataSource {
  Future<Either<Failure, List<CategoriesEntity>>> getCategories();
  Future<Either<Failure, void>> saveCategories(
      List<CategoriesEntity> categories);
  Future<Either<Failure, List<ProductEntity>>> getProducts();
  Future<Either<Failure, void>> saveProducts(List<ProductEntity> products);
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final HiveService hiveService;

  const HomeLocalDataSourceImpl({
    required this.hiveService,
  });

  @override
  Future<Either<Failure, List<CategoriesEntity>>> getCategories() async {
    try {
      final categories = await hiveService
          .loadData<CategoriesEntity>(HiveBoxesNames.kCategoriesBox);
      return right(categories);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveCategories(
      List<CategoriesEntity> categories) async {
    try {
      await hiveService.saveData<CategoriesEntity>(
          categories, HiveBoxesNames.kCategoriesBox);
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final products = await hiveService
          .loadData<ProductEntity>(HiveBoxesNames.kProductsBox);
      return right(products);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveProducts(
      List<ProductEntity> products) async {
    try {
      await hiveService.saveData<ProductEntity>(
          products, HiveBoxesNames.kProductsBox);
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
