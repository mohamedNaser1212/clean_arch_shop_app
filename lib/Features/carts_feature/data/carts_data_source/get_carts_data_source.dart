import '../../../../core/models/api_request_model/api_request_model.dart';
import '../../../../core/widgets/api_service.dart';
import '../carts_model/add_to_cart_model.dart';
import '../carts_model/changeCartModel.dart';

abstract class GetCartsDataSource {
  Future<List<AddToCartProduct>> getCarts();
  Future<List<AddToCartProduct>> removeCarts(num productId);
  Future<bool> toggleCarts(num productId);
}

class GetCartsDataSourceImpl implements GetCartsDataSource {
  final ApiService apiService;
  ChangeCartModel? changeCartModel;

  GetCartsDataSourceImpl({required this.apiService});

  @override
  Future<List<AddToCartProduct>> getCarts() async {
    try {
      ApiRequestModel request = ApiRequestModel(endpoint: 'carts');
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
    } catch (e) {
      print('Error in getCarts: $e');
      rethrow;
    }
  }

  @override
  Future<bool> toggleCarts(num productId) async {
    try {
      ApiRequestModel request = ApiRequestModel(
        endpoint: 'carts',
        data: {
          'product_id': productId,
        },
      );
      final response = await apiService.post(request: request);
      changeCartModel = ChangeCartModel.fromJson(response);
      return changeCartModel?.status ?? false;
    } catch (e) {
      print('Error in toggleCarts: $e');
      rethrow;
    }
  }

  @override
  Future<List<AddToCartProduct>> removeCarts(num productId) async {
    try {
      ApiRequestModel request = ApiRequestModel(
        endpoint: 'carts',
        data: {
          'product_id': productId,
        },
      );
      final response = await apiService.post(request: request);

      // Assuming response returns the updated cart items list
      List<AddToCartProduct> cartProducts = [];
      if (response['data']['cart_items'] != null) {
        for (var item in response['data']['cart_items']) {
          cartProducts.add(AddToCartProduct.fromJson(item['product']));
        }
      }
      cartProducts.removeWhere((element) => element.id == productId);

      return cartProducts;
    } catch (e) {
      print('Error in removeCarts: $e');
      rethrow;
    }
  }
}
