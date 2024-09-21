import 'package:shop_app/core/models/base_products_model.dart';

class SearchModel extends BaseProductModel {
  const SearchModel({
    required super.id,
    required super.price,
    required super.oldPrice,
    required super.discount,
    required super.image,
    required super.name,
    required super.description,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      id: json['id'],
      price: json['price'] ?? 0,
      oldPrice: json['old_price'] ?? 0,
      discount: json['discount'] ?? 0,
      image: json['image'],
      name: json['name'],
      description: json['description'],
    );
  }
}
