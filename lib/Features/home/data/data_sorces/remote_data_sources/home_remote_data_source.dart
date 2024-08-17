import 'package:shop_app/Features/home/domain/entities/categories_entity/categories_entity.dart';
import 'package:shop_app/core/models/api_request_model/api_request_model.dart';
import 'package:shop_app/core/widgets/end_points.dart';

import '../../../../../core/widgets/api_service.dart';
import '../../../domain/entities/products_entity/product_entity.dart';
import '../local_data_sources/save_categories.dart';

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
      ApiRequestModel request = ApiRequestModel(
        endpoint: homeEndPoint,
      );
      var data = await apiService.get(request: request);
      List<ProductEntity> products = getProductsList(data['data']);
      return products;
    } catch (e) {
      print('Error fetching featured products: $e');
      throw e;
    }
  }

  @override
  Future<List<CategoriesEntity>> fetchCategories() async {
    try {
      ApiRequestModel request = ApiRequestModel(
        endpoint: categoriesEndPoint,
      );
      var data = await apiService.get(request: request);
      List<CategoriesEntity> categories = getCategoriesList(data['data']);
      saveCategoriesData(categories, kCategoriesBox);
      return categories;
    } catch (e) {
      print('Error fetching categories: $e');
      throw e;
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
