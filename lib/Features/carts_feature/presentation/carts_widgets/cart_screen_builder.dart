import 'package:flutter/material.dart';
import 'package:shop_app/Features/carts_feature/presentation/carts_widgets/refresh_indicator_widget.dart';

import '../../domain/cart_entity/add_to_cart_entity.dart';

class CartScreenBody extends StatelessWidget {
  final List<CartEntity> cartModel;

  const CartScreenBody({
    super.key,
    required this.cartModel,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicatorWidget(
      cartModel: cartModel,
    );
  }
}
