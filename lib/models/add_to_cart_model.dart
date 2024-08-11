import 'package:shop_app/Features/home/domain/entities/add_to_cart_entity/add_to_cart_entity.dart';

class AddToCartModel {
  bool? status;
  String? message;
  CartData? data;

  AddToCartModel({this.status, this.message, this.data});

  AddToCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'] ?? '';
    data = json['data'] != null ? CartData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CartData {
  List<CartItem> cartItems = [];
  num? subTotal;
  num? total;
  CartData.fromJson(Map<String, dynamic> json) {
    subTotal = json['sub_total'];
    total = json['total'];
    if (json['cart_items'] != null) {
      json['cart_items'].forEach((v) {
        cartItems.add(CartItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sub_total'] = subTotal;
    data['total'] = total;
    data['cart_items'] = cartItems.map((v) => v.toJson()).toList();
    return data;
  }
}

class CartItem {
  num? id;
  num? quantity;
  AddToCartProduct? product;

  CartItem({this.id, this.quantity, this.product});

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product = json['product'] != null
        ? AddToCartProduct.fromJson(json['product'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = quantity;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class AddToCartProduct extends AddToCartEntity {
  AddToCartProduct({
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

  factory AddToCartProduct.fromJson(Map<String, dynamic> json) {
    return AddToCartProduct(
      id: json['id'],
      price: json['price'],
      oldPrice: json['old_price'],
      discount: json['discount'],
      image: json['image'],
      name: json['name'],
      description: json['description'],
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
