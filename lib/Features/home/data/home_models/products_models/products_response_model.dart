import 'package:shop_app/core/networks/api_manager/request_data_names.dart';

import '../../../domain/entities/products_entity/product_entity.dart';

class ProductResponseModel extends ProductEntity {
  const ProductResponseModel({
    required super.description,
    required super.inFavorites,
    required super.inCart,
    required super.id,
    required super.price,
    required super.oldPrice,
    required super.discount,
    required super.image,
    required super.name,
    required super.images,
  });

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) {
    return ProductResponseModel(
      description: json[RequestDataNames.description],
      inFavorites: json[RequestDataNames.inFavorites],
      inCart: json[RequestDataNames.inCart],
      id: json[RequestDataNames.id],
      name: json[RequestDataNames.name],
      oldPrice: json[RequestDataNames.oldPrice],
      discount: json[RequestDataNames.discount],
      price: json[RequestDataNames.price],
      image: json[RequestDataNames.image],
      images: List<String>.from(json[RequestDataNames.images]),
    );
  }
}
