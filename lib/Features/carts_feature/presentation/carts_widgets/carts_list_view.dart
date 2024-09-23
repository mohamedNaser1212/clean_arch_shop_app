import 'package:flutter/material.dart';
import 'package:shop_app/features/carts_feature/domain/cart_entity/add_to_cart_entity.dart';
import 'package:shop_app/features/carts_feature/presentation/carts_widgets/cart_item_widget.dart';

class CartsListView extends StatelessWidget {
  const CartsListView({
    super.key,
    required this.cartModel,
  });

  final List<CartEntity> cartModel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) =>
            CartItemWidget(model: cartModel[index]),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: cartModel.length,
      ),
    );
  }
}