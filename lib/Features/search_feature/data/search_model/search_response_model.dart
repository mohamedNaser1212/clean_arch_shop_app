import 'package:shop_app/core/models/base_products_model.dart';

class SearchResponseModel extends BaseProductModel {
  const SearchResponseModel({
    required super.id,
    required super.price,
    required super.oldPrice,
    required super.discount,
    required super.image,
    required super.name,
    required super.description,
  });

  factory SearchResponseModel.fromJson(Map<String, dynamic> json) {
    return SearchResponseModel(
      id: json['id'],
      price: json['price'],
      oldPrice: json['old_price'] ?? 0,
      discount: json['discount'] ?? 0,
      image: json['image'],
      name: json['name'],
      description: json['description'],
    );
  }
}
