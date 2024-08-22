import '../../../domain/entities/products_entity/product_entity.dart';

class Products extends ProductEntity {
  final String description;
  final bool inFavorites;
  final bool? inCart;

  const Products({
    required this.description,
    required this.inFavorites,
    this.inCart,
    required num id,
    required num price,
    required num oldPrice,
    required num discount,
    required String image,
    required String name,
    required List<String> images,
  }) : super(
          id: id,
          name: name,
          discount: discount,
          oldPrice: oldPrice,
          price: price,
          image: image,
          images: images,
          description: description,
          inFavorites: inFavorites,
          inCart: inCart,
        );

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      description: json['description'],
      inFavorites: json['in_favorites'],
      inCart: json['in_cart'],
      id: json['id'],
      name: json['name'],
      discount: json['discount'],
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
