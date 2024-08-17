import 'package:hive/hive.dart';

part 'product_entity.g.dart';

@HiveType(typeId: 0)
class ProductEntity {
  @HiveField(0)
  final num id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final num discount;
  @HiveField(3)
  final num price;
  @HiveField(4)
  final num oldPrice;
  @HiveField(5)
  final String image;
  @HiveField(6)
  final List<String> images;
  @HiveField(7)
  final String? description;
  @HiveField(8)
  final bool? inFavorites;
  @HiveField(9)
  bool inCart;

  ProductEntity({
    required this.id,
    required this.name,
    required this.discount,
    required this.oldPrice,
    required this.price,
    required this.image,
    required this.images,
    this.description,
    required this.inFavorites,
    this.inCart = false,
  });

  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    return ProductEntity(
      id: json['id'] as num,
      name: json['name'] as String,
      discount: json['discount'] as num,
      price: json['price'] as num,
      oldPrice: json['old_price'] as num,
      image: json['image'] as String,
      images: List<String>.from(json['images']),
      description: json['description'] as String?,
      inFavorites: json['in_favorites'] as bool,
      inCart: json['in_cart'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'discount': discount,
      'price': price,
      'old_price': oldPrice,
      'image': image,
      'images': images,
      'description': description,
      'in_favorites': inFavorites,
      'in_cart': inCart,
    };
  }
}
