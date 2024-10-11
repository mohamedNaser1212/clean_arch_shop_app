import 'package:flutter/material.dart';
import 'package:shop_app/Features/carts_feature/domain/cart_entity/add_to_cart_entity.dart';
import 'package:shop_app/Features/carts_feature/presentation/carts_widgets/cart_check_out_data.dart';
import 'package:shop_app/Features/carts_feature/presentation/carts_widgets/carts_list_view.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/get_carts_cubit/carts_cubit.dart';

class CartRefreshIndicatorWidgetBody extends StatelessWidget {
  const CartRefreshIndicatorWidgetBody({
    super.key,
    required this.cartModel,
  });

  final List<CartEntity> cartModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CartsListView(cartModel: cartModel),
        CartCheckoutData(
          total: CartsCubit.get(context).cartTotal(),
          cartModel: cartModel,
        ),
      ],
    );
  }
}
