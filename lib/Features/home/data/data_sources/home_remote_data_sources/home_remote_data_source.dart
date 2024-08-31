import '../../../../../core/networks/api_manager/api_helper.dart';
import '../../../../../core/networks/api_manager/api_request_model.dart';
import '../../../../../core/networks/api_manager/end_points.dart';
import '../../home_models/categories_models/categories_model.dart';
import '../../home_models/products_models/products_response_model.dart';

abstract class HomeRemoteDataSource {
  const HomeRemoteDataSource();
  Future<List<ProductResponseModel>> fetchProducts();

  Future<List<CategoryModel>> fetchCategories();
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiManager apiHelper;

  const HomeRemoteDataSourceImpl({
    required this.apiHelper,
  });

  @override
  Future<List<ProductResponseModel>> fetchProducts() async {
    ApiRequestModel request = ApiRequestModel(
      endpoint: EndPoints.homeEndPoint,
      headerModel: HeaderModel(),
    );
    var data = await apiHelper.get(request: request);
    List<ProductResponseModel> products = getProductsList(data['data']);
    return products;
  }

  @override
  Future<List<CategoryModel>> fetchCategories() async {
    ApiRequestModel request = ApiRequestModel(
      endpoint: EndPoints.categoriesEndPoint,
      headerModel: HeaderModel(),
    );
    var data = await apiHelper.get(request: request);
    List<CategoryModel> categories = getCategoriesList(data['data']);

    return categories;
  }

  List<ProductResponseModel> getProductsList(Map<String, dynamic> data) {
    List<ProductResponseModel> products = [];
    for (var productMap in data['products']) {
      products.add(ProductResponseModel.fromJson(productMap));
    }
    return products;
  }

  List<CategoryModel> getCategoriesList(Map<String, dynamic> data) {
    List<CategoryModel> categories = [];
    for (var categoryMap in data['data']) {
      categories.add(CategoryModel.fromJson(categoryMap));
    }
    return categories;
  }
}
