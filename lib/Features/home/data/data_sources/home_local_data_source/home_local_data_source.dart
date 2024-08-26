import '../../../../../core/networks/Hive_manager/hive_boxes_names.dart';
import '../../../../../core/networks/Hive_manager/hive_helper.dart';
import '../../../domain/entities/categories_entity/categories_entity.dart';
import '../../../domain/entities/products_entity/product_entity.dart';

abstract class HomeLocalDataSource {
  const HomeLocalDataSource();
  Future<List<CategoriesEntity>> getCategories();
  Future<void> saveCategories(List<CategoriesEntity> categories);
  Future<List<ProductEntity>> getProducts();
  Future<void> saveProducts(List<ProductEntity> products);
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final LocalStorageHelper hiveHelper;

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
  Future<void> saveCategories(List<CategoriesEntity> categories) async {
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
  Future<void> saveProducts(List<ProductEntity> products) async {
    await hiveHelper.saveData<ProductEntity>(
        products, HiveBoxesNames.kProductsBox);
  }
}
