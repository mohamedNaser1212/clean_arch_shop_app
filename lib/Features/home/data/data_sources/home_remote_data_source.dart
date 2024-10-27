import 'package:shop_app/core/networks/api_manager/request_data_names.dart';

import '../../../../core/networks/api_manager/api_manager.dart';
import '../../../../core/networks/api_manager/api_request_model.dart';
import '../../../../core/networks/api_manager/end_points.dart';
import '../home_models/categories_models/categories_model.dart';
import '../home_models/products_models/products_response_model.dart';

abstract class HomeRemoteDataSource {
  const HomeRemoteDataSource();
  Future<List<ProductResponseModel>> fetchProducts();

  Future<List<CategoryModel>> fetchCategories();
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiHelper apiHelper;

  const HomeRemoteDataSourceImpl({
    required this.apiHelper,
  });

  @override
  Future<List<ProductResponseModel>> fetchProducts() async {
    ApiRequestModel request = ApiRequestModel(
      endpoint: EndPoints.productsEndPoint,
      headerModel: HeaderModel(),
    );
    var data = await apiHelper.get(request: request);
    List<ProductResponseModel> products =
        _getProductsList(data[RequestDataNames.data]);

    return products;
  }

  @override
  Future<List<CategoryModel>> fetchCategories() async {
    ApiRequestModel request = ApiRequestModel(
      endpoint: EndPoints.categoriesEndPoint,
      headerModel: HeaderModel(),
    );
    var data = await apiHelper.get(request: request);
    List<CategoryModel> categories =
        _getCategoriesList(data[RequestDataNames.data]);

    return categories;
  }

  List<ProductResponseModel> _getProductsList(Map<String, dynamic> data) {
    List<ProductResponseModel> products = [];
    for (var productMap in data[RequestDataNames.products]) {
      products.add(ProductResponseModel.fromJson(productMap));
    }
    return products;
  }

  List<CategoryModel> _getCategoriesList(Map<String, dynamic> data) {
    List<CategoryModel> categories = [];
    for (var categoryMap in data[RequestDataNames.data]) {
      categories.add(CategoryModel.fromJson(categoryMap));
    }
    return categories;
  }
}
