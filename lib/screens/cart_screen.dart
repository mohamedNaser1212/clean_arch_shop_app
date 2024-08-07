import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_app/Features/home/presentation/manager/shop_cubit/shop_cubit.dart';
import 'package:shop_app/Features/home/presentation/manager/shop_cubit/shop_state.dart';

import '../core/widgets/cart_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cartItems = ShopCubit.get(context).cartModel;
        if (cartItems == null || cartItems.isEmpty) {
          return const Center(
            child: Text('Your cart is empty'),
          );
        }

        return ConditionalBuilder(
          condition: state is! ShopGetCartItemsLoadingState,
          builder: (context) => Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: double.infinity,
            child: ListView.separated(
              itemBuilder: (context, index) => CartWidget(
                model: cartItems[index],
                isInCart: ShopCubit.get(context).isInCart(cartItems[index].id),
              ),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: cartItems.length,
            ),
          ),
          fallback: (context) => Center(
            child:
                LoadingAnimationWidget.waveDots(color: Colors.grey, size: 90),
          ),
        );
      },
    );
  }
}
