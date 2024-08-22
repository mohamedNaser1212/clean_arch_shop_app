import 'add_product_to_cart_model.dart';

class CartItem {
  final num? id;
  final num? quantity;
  final AddProductToCartModel? product;

  const CartItem({this.id, this.quantity, this.product});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      quantity: json['quantity'],
      product: json['product'] != null
          ? AddProductToCartModel.fromJson(json['product'])
          : null,
    );
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
