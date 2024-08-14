import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../Features/home/presentation/manager/shop_cubit/shop_cubit.dart';
import '../Features/home/presentation/manager/shop_cubit/shop_state.dart';
import '../core/widgets/cart_check_out_data.dart';
import '../core/widgets/cart_item_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        // Add any necessary listeners for specific states if required
      },
      builder: (context, state) {
        return _CartScreenContent(state: state);
      },
    );
  }
}

class _CartScreenContent extends StatelessWidget {
  final ShopStates state;

  const _CartScreenContent({required this.state});

  @override
  Widget build(BuildContext context) {
    var cartModel = ShopCubit.get(context).cartModel;
    var subtotal = ShopCubit.get(context).cartSubtotal;
    var total = ShopCubit.get(context).cartTotal;

    if (cartModel == null || cartModel.isEmpty) {
      return const Center(
        child: Text('Sorry, there are no items in the cart'),
      );
    }

    return ConditionalBuilder(
      condition: state is! ShopGetCartItemsLoadingState &&
          state is! ShopChangeCartItemsLoadingState,
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
            subtotal: subtotal,
            total: total,
            cartModel: cartModel, // Pass the cartModel to CartCheckoutData
          ),
        ],
      ),
      fallback: (context) => Center(
        child: LoadingAnimationWidget.waveDots(color: Colors.grey, size: 90),
      ),
    );
  }
}
