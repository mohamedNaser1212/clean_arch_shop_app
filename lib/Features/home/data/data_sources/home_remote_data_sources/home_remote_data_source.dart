import 'package:shop_app/Features/home/data/home_models/categories_model.dart';
import 'package:shop_app/core/models/api_request_model/api_request_model.dart';

import '../../../../../core/utils/screens/widgets/api_service.dart';
import '../../../../../core/utils/screens/widgets/end_points.dart';
import '../../home_models/home_data_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<Products>> fetchFeaturedProducts();

  Future<List<CategoriesData>> fetchCategories();
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiService apiService;

  HomeRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<Products>> fetchFeaturedProducts() async {
    try {
      ApiRequestModel request = ApiRequestModel(
        endpoint: homeEndPoint,
      );
      var data = await apiService.get(request: request);
      List<Products> products = getProductsList(data['data']);
      return products;
    } catch (e) {
      print('Error fetching featured products: $e');
      throw e;
    }
  }

  @override
  Future<List<CategoriesData>> fetchCategories() async {
    try {
      ApiRequestModel request = ApiRequestModel(
        endpoint: categoriesEndPoint,
      );
      var data = await apiService.get(request: request);
      List<CategoriesData> categories = getCategoriesList(data['data']);

      return categories;
    } catch (e) {
      print('Error fetching categories: $e');
      throw e;
    }
  }

  List<Products> getProductsList(Map<String, dynamic> data) {
    List<Products> products = [];
    for (var productMap in data['products']) {
      products.add(Products.fromJson(productMap));
    }
    return products;
  }

  List<CategoriesData> getCategoriesList(Map<String, dynamic> data) {
    List<CategoriesData> categories = [];
    for (var categoryMap in data['data']) {
      categories.add(CategoriesData.fromJson(categoryMap));
    }
    return categories;
  }
}
