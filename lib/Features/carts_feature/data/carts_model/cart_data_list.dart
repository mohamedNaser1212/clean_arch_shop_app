import 'cart_item.dart';

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
