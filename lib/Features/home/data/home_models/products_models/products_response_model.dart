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
      description: json['description'],
      inFavorites: json['in_favorites'],
      inCart: json['in_cart'],
      id: json['id'],
      name: json['name'],
      oldPrice: json['old_price'] ?? 0,
      discount: json['discount'] ?? 0,
      price: json['price'],
      image: json['image'],
      images: List<String>.from(json['images']),
    );
  }
}
