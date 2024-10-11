import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Features/carts_feature/presentation/carts_widgets/cart_refresh_indicator_widget_builder.dart';
import 'package:shop_app/core/widgets/loading_indicator_widget.dart';

import '../../domain/cart_entity/add_to_cart_entity.dart';
import '../cubit/get_carts_cubit/carts_cubit.dart';

class CartRefreshIndicatorWidget extends StatelessWidget {
  const CartRefreshIndicatorWidget({super.key, required this.cartModel});
  final List<CartEntity> cartModel;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => CartsCubit.get(context).getCarts(),
      child: ConditionalBuilder(
        condition: cartModel.isNotEmpty,
        builder: (context) =>
            CartRefreshIndicatorWidgetBody(cartModel: cartModel),
        fallback: (context) => const Center(
          child: LoadingIndicatorWidget(),
        ),
      ),
    );
  }
}
