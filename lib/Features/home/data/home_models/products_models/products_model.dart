import '../../../domain/entities/products_entity/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
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

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      description: json['description'],
      inFavorites: json['in_favorites'],
      inCart: json['in_cart'],
      id: json['id'],
      name: json['name'],
      discount: json['discount'] ?? 0,
      price: json['price'],
      oldPrice: json['old_price'],
      image: json['image'],
      images: List<String>.from(json['images']),
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['description'] = description;
    map['in_favorites'] = inFavorites;
    map['in_cart'] = inCart;
    map['id'] = id;
    map['name'] = name;
    map['discount'] = discount;
    map['price'] = price;
    map['old_price'] = oldPrice;
    map['image'] = image;
    map['images'] = images;
    return map;
  }
}
