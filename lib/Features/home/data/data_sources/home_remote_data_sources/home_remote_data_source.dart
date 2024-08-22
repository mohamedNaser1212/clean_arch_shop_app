import '../../../../../core/networks/api_manager/api_request_model.dart';
import '../../../../../core/networks/api_manager/api_service_interface.dart';
import '../../../../../core/networks/api_manager/end_points.dart';
import '../../home_models/categories_models/categories_data.dart';
import '../../home_models/products_models/products_model.dart';

abstract class HomeRemoteDataSource {
  const HomeRemoteDataSource();
  Future<List<Products>> fetchProducts();

  Future<List<CategoriesData>> fetchCategories();
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiServiceInterface apiService;

  const HomeRemoteDataSourceImpl({
    required this.apiService,
  });

  @override
  Future<List<Products>> fetchProducts() async {
    try {
      ApiRequestModel request = ApiRequestModel(
        endpoint: EndPoints.homeEndPoint,
        headerModel: HeaderModel(),
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
        endpoint: EndPoints.categoriesEndPoint,
        headerModel: HeaderModel(),
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
