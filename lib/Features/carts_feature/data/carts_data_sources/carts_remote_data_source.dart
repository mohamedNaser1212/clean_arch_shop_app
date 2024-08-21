import 'package:shop_app/core/utils/widgets/token_storage_helper.dart';

import '../../../../core/networks/api_manager/api_request_model.dart';
import '../../../../core/networks/api_manager/api_service_interface.dart';
import '../../../../core/utils/dio_data_name.dart';
import '../../../../core/utils/end_points/end_points.dart';
import '../carts_model/add_to_cart_model.dart';
import '../carts_model/changeCartModel.dart';

abstract class CartsRemoteDataSource {
  Future<List<AddToCartProduct>> getCarts();
  Future<List<AddToCartProduct>> removeCarts(num productId);
  Future<bool> toggleCarts(num productId);
}

class CartsRemoteDataSourceImpl implements CartsRemoteDataSource {
  final ApiServiceInterface apiService;
  ChangeCartModel? changeCartModel;
  final token = HiveHelper.getToken();

  CartsRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<AddToCartProduct>> getCarts() async {
    ApiRequestModel request = ApiRequestModel(
        endpoint: EndPoints.cartEndPoint,
        headerModel: HeaderModel(authorization: token));
    final response = await apiService.get(request: request);

    List<AddToCartProduct> cartProducts = [];
    if (response['data']['cart_items'] != null) {
      for (var item in response['data']['cart_items']) {
        cartProducts.add(AddToCartProduct.fromJson(item['product']));
      }
    }
    print('done');
    print(cartProducts.length);
    return cartProducts;
  }

  @override
  Future<bool> toggleCarts(num productId) async {
    ApiRequestModel request = ApiRequestModel(
        endpoint: EndPoints.cartEndPoint,
        data: {
          DioDataName.productId: productId,
        },
        headerModel: HeaderModel(authorization: token));

    final response = await apiService.post(request: request);
    changeCartModel = ChangeCartModel.fromJson(response);
    getCarts();
    return changeCartModel?.status ?? false;
  }

  @override
  Future<List<AddToCartProduct>> removeCarts(num productId) async {
    ApiRequestModel request = ApiRequestModel(
      endpoint: EndPoints.cartEndPoint,
      data: {
        DioDataName.productId: productId,
      },
      headerModel: HeaderModel(authorization: token),
    );
    final response = await apiService.post(request: request);

    List<AddToCartProduct> cartProducts = [];
    if (response['data']['cart_items'] != null) {
      for (var item in response['data']['cart_items']) {
        cartProducts.add(AddToCartProduct.fromJson(item['product']));
      }
    }
    cartProducts.removeWhere((element) => element.id == productId);

    return cartProducts;
  }
}
