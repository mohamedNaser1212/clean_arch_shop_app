import 'package:shop_app/Features/home/domain/entities/categories_entity/categories_entity.dart';
import 'package:shop_app/core/widgets/end_points.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/new_get_home_data.dart';

import '../../../../../core/widgets/api_service.dart';

abstract class HomeRemoteDataSource {
  Future<List<Products>> fetchFeaturedProducts();

  Future<List<CategoriesEntity>> fetchCategories();
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiService apiService;

  HomeRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<Products>> fetchFeaturedProducts() async {
    var data = await apiService.get(endPoint: homeEndPoint);
    List<Products> products = getProductsList(data['data']);
    //  saveproductsData(products, kProductsBox);
    return products;
  }

  @override
  Future<List<CategoriesEntity>> fetchCategories() async {
    var data = await apiService.get(endPoint: categoriesEndPoint);
    List<CategoriesEntity> categories = getCategoriesList(data['data']);
    //saveCategoriesData(categories, kCategoriesBox);
    return categories;
  }

  List<Products> getProductsList(Map<String, dynamic> data) {
    List<Products> products = [];
    for (var productMap in data['products']) {
      products.add(Products.fromJson(productMap));
    }
    return products;
  }

  List<CategoriesEntity> getCategoriesList(Map<String, dynamic> data) {
    List<CategoriesEntity> categories = [];
    for (var categoryMap in data['data']) {
      categories.add(DataModel.fromJson(categoryMap));
    }
    return categories;
  }
}
