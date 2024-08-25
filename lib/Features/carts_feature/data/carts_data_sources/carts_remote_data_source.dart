import '../../../../core/networks/api_manager/api_helper.dart';
import '../../../../core/networks/api_manager/api_request_model.dart';
import '../../../../core/networks/api_manager/dio_data_name.dart';
import '../../../../core/networks/api_manager/end_points.dart';
import '../carts_model/cart_response_model.dart';

abstract class CartsRemoteDataSource {
  const CartsRemoteDataSource();
  Future<List<CartResponseModel>> getCarts();
  Future<List<CartResponseModel>> removeCarts(num productId);
  Future<bool> toggleCarts(num productId);
}

class CartsRemoteDataSourceImpl implements CartsRemoteDataSource {
  final ApiHelper apiHelper;

  const CartsRemoteDataSourceImpl({required this.apiHelper});

  @override
  Future<List<CartResponseModel>> getCarts() async {
    ApiRequestModel request = ApiRequestModel(
        endpoint: EndPoints.cartEndPoint, headerModel: HeaderModel());

    final response = await apiHelper.get(request: request);

    List<CartResponseModel> cartProducts = [];
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

    final response = await apiHelper.post(request: request);

    getCarts();
    return response['status'] == true ? true : false;
  }

  @override
  Future<List<CartResponseModel>> removeCarts(num productId) async {
    ApiRequestModel request = ApiRequestModel(
      endpoint: EndPoints.cartEndPoint,
      data: {
        RequestDataNames.productId: productId,
      },
      headerModel: HeaderModel(),
    );
    final response = await apiHelper.post(request: request);

    List<CartResponseModel> cartProducts = [];
    removeCartItems(response, cartProducts);
    cartProducts.removeWhere((element) => element.id == productId);

    return cartProducts;
  }

  void removeCartItems(
      Map<String, dynamic> response, List<CartResponseModel> cartProducts) {
    if (response['data']['cart_items'] != null) {
      for (var item in response['data']['cart_items']) {
        cartProducts.add(CartResponseModel.fromJson(item['product']));
      }
    }
  }
}
