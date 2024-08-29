import 'package:flutter/material.dart';

import '../../../../Features/carts_feature/domain/cart_entity/add_to_cart_entity.dart';

abstract class PaymentRepo {
  Future<void> makePayment(int amount, String currency, BuildContext context,
      List<CartEntity> model);
}
