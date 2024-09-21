import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_refresh_indicator.dart';
import '../../domain/cart_entity/add_to_cart_entity.dart';
import '../cubit/carts_cubit.dart';
import 'cart_item_widget.dart';

class CartScreenBody extends StatelessWidget {
  final List<CartEntity> cartModel;

  const CartScreenBody({
    super.key,
    required this.cartModel,
  });

  Future<void> _refreshCart(BuildContext context) async {
    await CartsCubit.get(context).getCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: _refreshCart,
      items: cartModel,
      itemBuilder: (context, model) => CartItemWidget(model: model),
      fallback: const Center(
        child: Text('Your cart is empty'),
      ),
    );
  }
}
