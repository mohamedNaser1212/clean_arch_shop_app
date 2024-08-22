import '../../domain/cart_entity/add_to_cart_entity.dart';

class AddProductToCartModel extends AddToCartEntity {
  const AddProductToCartModel({
    num? id,
    num? price,
    num? oldPrice,
    num? discount,
    String? image,
    String? name,
    String? description,
  }) : super(
          id: id,
          price: price,
          oldPrice: oldPrice,
          discount: discount,
          image: image,
          name: name,
          description: description,
        );

  factory AddProductToCartModel.fromJson(Map<String, dynamic> json) {
    return AddProductToCartModel(
      id: json['id'] ?? '',
      price: json['price'] ?? 0,
      oldPrice: json['old_price'] ?? 0,
      discount: json['discount'] ?? 0,
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'old_price': oldPrice,
      'discount': discount,
      'image': image,
      'name': name,
      'description': description,
    };
  }
}
