import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/core/widgets/loading_indicator.dart';

import '../../domain/cart_entity/add_to_cart_entity.dart';
import '../cubit/carts_cubit.dart';
import 'cart_check_out_data.dart';
import 'cart_item_widget.dart';

class RefreshIndicatorWidget extends StatelessWidget {
  const RefreshIndicatorWidget({super.key, required this.cartModel});
  final List<CartEntity> cartModel;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => CartsCubit.get(context).getCartItems(),
      child: ConditionalBuilder(
        condition: cartModel.isNotEmpty,
        builder: (context) => Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) =>
                    CartItemWidget(model: cartModel[index]),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: cartModel.length,
              ),
            ),
            CartCheckoutData(
              total: CartsCubit.get(context).cartTotal(),
              cartModel: cartModel,
            ),
          ],
        ),
        fallback: (context) => const Center(
          child: LoadingIndicatorWidget(),
        ),
      ),
    );
  }
}
