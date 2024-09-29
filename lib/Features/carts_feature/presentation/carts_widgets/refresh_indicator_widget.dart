import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Features/carts_feature/presentation/carts_widgets/carts_list_view.dart';
import 'package:shop_app/core/widgets/loading_indicator.dart';

import '../../domain/cart_entity/add_to_cart_entity.dart';
import '../cubit/carts_cubit.dart';
import 'cart_check_out_data.dart';

class RefreshIndicatorWidget extends StatelessWidget {
  const RefreshIndicatorWidget({super.key, required this.cartModel});
  final List<CartEntity> cartModel;
  @override
  Widget build(BuildContext context) {
      return RefreshIndicator(
    onRefresh: () => CartsCubit.get(context).getCarts(),
    child: ConditionalBuilder(
      condition: cartModel.isNotEmpty,
      builder: _builder,
      fallback: (context) => const Center(
        child: LoadingIndicatorWidget(),
      ),
    ),
  );
  }



  Widget _builder(context) => Column(
        children: [
          CartsListView(cartModel: cartModel),
          CartCheckoutData(
            total: CartsCubit.get(context).cartTotal(),
            cartModel: cartModel,
          ),
        ],
      );
}
