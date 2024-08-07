import 'package:shop_app/Features/home/domain/entities/add_to_cart_entity/add_to_cart_entity.dart';

class AddToCartModel {
  AddToCartModel({
    this.status,
    this.message,
    this.data,
  });

  factory AddToCartModel.fromJson(Map<String, dynamic> json) {
    return AddToCartModel(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? CartData.fromJson(json['data']) : null,
    );
  }

  final bool? status;
  final String? message;
  final CartData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class CartData {
  CartData({
    this.cartItems,
    this.subTotal,
    this.total,
  });

  factory CartData.fromJson(Map<String, dynamic> json) {
    return CartData(
      cartItems: json['cart_items'] != null
          ? (json['cart_items'] as List)
              .map((item) => CartItem.fromJson(item))
              .toList()
          : [],
      subTotal: json['sub_total'] is String
          ? double.tryParse(json['sub_total']) ?? 0.0
          : json['sub_total']?.toDouble(),
      total: json['total'] is String
          ? double.tryParse(json['total']) ?? 0.0
          : json['total']?.toDouble(),
    );
  }

  final List<CartItem>? cartItems;
  final num? subTotal;
  final num? total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (cartItems != null) {
      map['cart_items'] = cartItems?.map((item) => item.toJson()).toList();
    }
    map['sub_total'] = subTotal;
    map['total'] = total;
    return map;
  }
}

class CartItem extends AddToCartEntity {
  CartItem({
    required num id,
    required String quantity,
    required AddToCartProduct product,
  }) : super(
          id: id,
          name: product.name,
          price: product.price,
          image: product.image,
          quantity: quantity,
          description: product.description,
          oldPrice: product.oldPrice,
        );

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] ?? 0,
      quantity: json['quantity'] is String
          ? int.tryParse(json['quantity']) ?? 0
          : json['quantity'],
      product: json['product'] != null
          ? AddToCartProduct.fromJson(json['product'])
          : AddToCartProduct(
              id: 0,
              price: 0,
              oldPrice: 0,
              discount: 0,
              image: '',
              name: '',
              description: '',
            ),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['quantity'] = quantity;
    // map['product'] = product.toJson();
    return map;
  }
}

class AddToCartProduct {
  AddToCartProduct({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
  });

  factory AddToCartProduct.fromJson(Map<String, dynamic> json) {
    return AddToCartProduct(
      id: json['id'] ?? 0,
      price: json['price'] is String
          ? double.tryParse(json['price']) ?? 0.0
          : json['price']?.toDouble(),
      oldPrice: json['old_price'] is String
          ? double.tryParse(json['old_price']) ?? 0.0
          : json['old_price']?.toDouble(),
      discount: json['discount'] is String
          ? double.tryParse(json['discount']) ?? 0.0
          : json['discount']?.toDouble(),
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }

  final num id;
  final num price;
  final num oldPrice;
  final num discount;
  final String image;
  final String name;
  final String description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['price'] = price;
    map['old_price'] = oldPrice;
    map['discount'] = discount;
    map['image'] = image;
    map['name'] = name;
    map['description'] = description;
    return map;
  }
}
