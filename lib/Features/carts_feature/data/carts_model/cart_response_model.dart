import 'package:shop_app/core/networks/api_manager/request_data_names.dart';

import '../../domain/cart_entity/add_to_cart_entity.dart';

class CartResponseModel extends CartEntity {
  const CartResponseModel({
    required super.id,
    required super.price,
    required super.oldPrice,
    required super.discount,
    required super.image,
    required super.name,
    required super.description,
  });

  factory CartResponseModel.fromJson(Map<String, dynamic> json) {
    return CartResponseModel(
      id: json[RequestDataNames.id],
      price: json[RequestDataNames.price],
      oldPrice: json[RequestDataNames.oldPrice] ?? 0,
      discount: json[RequestDataNames.discount] ?? 0,
      image: json[RequestDataNames.image],
      name: json[RequestDataNames.name],
      description: json[RequestDataNames.description],
    );
  }
}
