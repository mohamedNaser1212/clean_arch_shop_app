import '../../../../core/networks/api_manager/api_helper.dart';
import '../../../../core/networks/api_manager/api_request_model.dart';
import '../../../../core/networks/api_manager/dio_data_name.dart';
import '../../../../core/networks/api_manager/end_points.dart';
import '../carts_model/add_product_to_cart_model.dart';
import '../carts_model/changeCartModel.dart';

abstract class CartsRemoteDataSource {
  Future<List<AddProductToCartModel>> getCarts();
  Future<List<AddProductToCartModel>> removeCarts(num productId);
  Future<bool> toggleCarts(num productId);
}

class CartsRemoteDataSourceImpl implements CartsRemoteDataSource {
  final ApiHelper apiService;

  const CartsRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<AddProductToCartModel>> getCarts() async {
    // final token = HiveHelper.getToken();
    ApiRequestModel request = ApiRequestModel(
        endpoint: EndPoints.cartEndPoint, headerModel: HeaderModel());

    final response = await apiService.get(request: request);

    List<AddProductToCartModel> cartProducts = [];
    if (response['data']['cart_items'] != null) {
      for (var item in response['data']['cart_items']) {
        cartProducts.add(AddProductToCartModel.fromJson(item['product']));
      }
    }
    print('done');
    print(cartProducts.length);
    return cartProducts;
  }

  @override
  Future<bool> toggleCarts(num productId) async {
    ChangeCartModel? changeCartModel;

    ApiRequestModel request = ApiRequestModel(
      endpoint: EndPoints.cartEndPoint,
      data: {
        RequestDataNames.productId: productId,
      },
      headerModel: HeaderModel(),
    );

    final response = await apiService.post(request: request);
    changeCartModel = ChangeCartModel.fromJson(response);
    getCarts();
    return changeCartModel.status ?? false;
  }

  @override
  Future<List<AddProductToCartModel>> removeCarts(num productId) async {
    ApiRequestModel request = ApiRequestModel(
      endpoint: EndPoints.cartEndPoint,
      data: {
        RequestDataNames.productId: productId,
      },
      headerModel: HeaderModel(),
    );
    final response = await apiService.post(request: request);

    List<AddProductToCartModel> cartProducts = [];
    if (response['data']['cart_items'] != null) {
      for (var item in response['data']['cart_items']) {
        cartProducts.add(AddProductToCartModel.fromJson(item['product']));
      }
    }
    cartProducts.removeWhere((element) => element.id == productId);

    return cartProducts;
  }
}
