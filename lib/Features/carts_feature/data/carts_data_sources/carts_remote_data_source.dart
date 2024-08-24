import '../../../../core/networks/api_manager/api_helper.dart';
import '../../../../core/networks/api_manager/api_request_model.dart';
import '../../../../core/networks/api_manager/dio_data_name.dart';
import '../../../../core/networks/api_manager/end_points.dart';
import '../carts_model/add_product_to_cart_model.dart';

abstract class CartsRemoteDataSource {
  const CartsRemoteDataSource();
  Future<List<CartModel>> getCarts();
  Future<List<CartModel>> removeCarts(num productId);
  Future<bool> toggleCarts(num productId);
}

class CartsRemoteDataSourceImpl implements CartsRemoteDataSource {
  final ApiHelper apiService;

  const CartsRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<CartModel>> getCarts() async {
    // final token = HiveHelper.getToken();
    ApiRequestModel request = ApiRequestModel(
        endpoint: EndPoints.cartEndPoint, headerModel: HeaderModel());

    final response = await apiService.get(request: request);

    List<CartModel> cartProducts = [];
    removeCartItems(response, cartProducts);
    print('done');
    print(cartProducts.length);
    return cartProducts;
  }

  @override
  Future<bool> toggleCarts(num productId) async {
    ApiRequestModel request = ApiRequestModel(
      endpoint: EndPoints.cartEndPoint,
      data: {
        RequestDataNames.productId: productId,
      },
      headerModel: HeaderModel(),
    );

    final response = await apiService.post(request: request);

    getCarts();
    return response['status'] == true ? true : false;
  }

  @override
  Future<List<CartModel>> removeCarts(num productId) async {
    ApiRequestModel request = ApiRequestModel(
      endpoint: EndPoints.cartEndPoint,
      data: {
        RequestDataNames.productId: productId,
      },
      headerModel: HeaderModel(),
    );
    final response = await apiService.post(request: request);

    List<CartModel> cartProducts = [];
    removeCartItems(response, cartProducts);
    cartProducts.removeWhere((element) => element.id == productId);

    return cartProducts;
  }

  void removeCartItems(
      Map<String, dynamic> response, List<CartModel> cartProducts) {
    if (response['data']['cart_items'] != null) {
      for (var item in response['data']['cart_items']) {
        cartProducts.add(CartModel.fromJson(item['product']));
      }
    }
  }
}
