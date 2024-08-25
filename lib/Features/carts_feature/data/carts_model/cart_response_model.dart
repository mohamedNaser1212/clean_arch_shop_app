import '../../domain/cart_entity/add_to_cart_entity.dart';

class CartResponseModel extends AddToCartEntity {
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
