import 'package:shop_app/Features/home/domain/entities/categories_entity/categories_entity.dart';
import 'package:shop_app/core/widgets/end_points.dart';

import '../../../../../core/utils/funactions/save_categories.dart';
import '../../../../../core/utils/funactions/save_products.dart';
import '../../../../../core/widgets/api_service.dart';
import '../../../domain/entities/products_entity/product_entity.dart';

abstract class HomeRemoteDataSource {
  Future<List<ProductEntity>> fetchFeaturedProducts();

  Future<List<CategoriesEntity>> fetchCategories();
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiService apiService;

  HomeRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<ProductEntity>> fetchFeaturedProducts() async {
    try {
      var data = await apiService.get(endPoint: homeEndPoint);
      List<ProductEntity> products = getProductsList(data['data']);
      saveProductsData(products, kProductsBox);
      return products;
    } catch (e) {
      print('Error fetching featured products: $e');
      return await loadProducts(kProductsBox);
    }
  }

  @override
  Future<List<CategoriesEntity>> fetchCategories() async {
    try {
      var data = await apiService.get(endPoint: categoriesEndPoint);
      List<CategoriesEntity> categories = getCategoriesList(data['data']);
      saveCategoriesData(categories, kCategoriesBox);
      return categories;
    } catch (e) {
      print('Error fetching categories: $e');
      return await loadCategories(kCategoriesBox);
    }
  }

  List<ProductEntity> getProductsList(Map<String, dynamic> data) {
    List<ProductEntity> products = [];
    for (var productMap in data['products']) {
      products.add(ProductEntity.fromJson(productMap));
    }
    return products;
  }

  List<CategoriesEntity> getCategoriesList(Map<String, dynamic> data) {
    List<CategoriesEntity> categories = [];
    for (var categoryMap in data['data']) {
      categories.add(CategoriesEntity.fromJson(categoryMap));
    }
    return categories;
  }
}
