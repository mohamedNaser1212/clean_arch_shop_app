import '../../../../core/networks/api_manager/api_manager.dart';
import '../../../../core/networks/api_manager/api_request_model.dart';
import '../../../../core/networks/api_manager/request_data_names.dart';
import '../../../../core/networks/api_manager/end_points.dart';
import '../carts_model/cart_response_model.dart';

abstract class CartsRemoteDataSource {
  const CartsRemoteDataSource._();
  Future<List<CartResponseModel>> getCarts();
  Future<List<CartResponseModel>> removeCarts({
    required num productId,
  });
  Future<bool> toggleCarts({
    required num productId,
  });
}

class CartsRemoteDataSourceImpl implements CartsRemoteDataSource {
  final ApiHelper apiHelper;

  const CartsRemoteDataSourceImpl({required this.apiHelper});

  @override
  Future<List<CartResponseModel>> getCarts() async {
    ApiRequestModel request = ApiRequestModel(
      endpoint: EndPoints.cartEndPoint,
      headerModel: HeaderModel(),
    );

    final response = await apiHelper.get(request: request);
    List<CartResponseModel> cartProducts = [];
    _cartItems(response, cartProducts);
    return cartProducts;
  }

  @override
  Future<bool> toggleCarts({
    required num productId,
  }) async {
    ApiRequestModel request = ApiRequestModel(
      endpoint: EndPoints.cartEndPoint,
      data: {
        RequestDataNames.productId: productId,
      },
      headerModel: HeaderModel(),
    );
    final response = await apiHelper.post(request: request);
    await getCarts();
    return response[RequestDataNames.status] == true ? true : false;
  }

  @override
  Future<List<CartResponseModel>> removeCarts({
    required num productId,
  }) async {
    ApiRequestModel request = ApiRequestModel(
      endpoint: EndPoints.cartEndPoint,
      data: {
        RequestDataNames.productId: productId,
      },
      headerModel: HeaderModel(),
    );

    final response = await apiHelper.post(request: request);
    List<CartResponseModel> cartProducts = [];
    _cartItems(response, cartProducts);
    cartProducts.removeWhere((element) => element.id == productId);
    return cartProducts;
  }

  void _cartItems(
      Map<String, dynamic> response, List<CartResponseModel> cartProducts) {
    final cartItems = response[RequestDataNames.data]?[RequestDataNames.cartItems];
    if (cartItems != null) {
      for (var item in cartItems) {
        cartProducts.add(CartResponseModel.fromJson(item[RequestDataNames.product]));
      }
    }
  }
}
