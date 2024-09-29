import 'package:flutter/material.dart';
import 'package:shop_app/Features/carts_feature/domain/cart_entity/add_to_cart_entity.dart';

import 'package:shop_app/core/widgets/custom_refresh_indicator.dart';

class CartsListView extends StatelessWidget {
  const CartsListView({
    super.key,
    required this.cartModel,
  });

  final List<CartEntity> cartModel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomRefreshIndicator.carts(
        context: context,
        model: cartModel,
      ),
    );
  }
}
