import '../../../../../core/networks/hive_manager/hive_boxes_names.dart';
import '../../../../../core/networks/hive_manager/hive_helper.dart';
import '../../../domain/entities/categories_entity/categories_entity.dart';
import '../../../domain/entities/products_entity/product_entity.dart';

abstract class HomeLocalDataSource {
  const HomeLocalDataSource._();
  Future<List<CategoriesEntity>> getCategories();
  Future<void> saveCategories({
    required List<CategoriesEntity> categories,
  });
  Future<List<ProductEntity>> getProducts();
  Future<void> saveProducts({
    required List<ProductEntity> products,
  });
  Future<void> clearCategories();

  Future<void> clearProducts();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final LocalStorageManager hiveHelper;

  const HomeLocalDataSourceImpl({
    required this.hiveHelper,
  });

  @override
  Future<List<CategoriesEntity>> getCategories() async {
    final categories = await hiveHelper
        .loadData<CategoriesEntity>(HiveBoxesNames.kCategoriesBox);
    return categories;
  }

  @override
  Future<void> saveCategories({
    required List<CategoriesEntity> categories,
  }) async {
    await hiveHelper.saveData<CategoriesEntity>(
        categories, HiveBoxesNames.kCategoriesBox);
  }

  @override
  Future<List<ProductEntity>> getProducts() async {
    final products =
        await hiveHelper.loadData<ProductEntity>(HiveBoxesNames.kProductsBox);
    return products;
  }

  @override
  Future<void> saveProducts({
    required List<ProductEntity> products,
  }) async {
    await hiveHelper.saveData<ProductEntity>(
        products, HiveBoxesNames.kProductsBox);
  }

  @override
  Future<void> clearCategories() async {
    await hiveHelper.clearData(HiveBoxesNames.kCategoriesBox);
  }

  @override
  Future<void> clearProducts() async {
    await hiveHelper.clearData(HiveBoxesNames.kProductsBox);
  }
}
