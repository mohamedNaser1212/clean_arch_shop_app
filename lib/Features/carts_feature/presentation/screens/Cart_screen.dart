import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/carts_cubit.dart';
import 'package:shop_app/core/payment_gate_way_manager/cubit/payment_cubit.dart';

import '../../../../core/functions/toast_function.dart';
import '../../../../core/utils/styles_manager/color_manager.dart';
import '../../../../core/widgets/custom_title.dart';
import '../carts_widgets/cart_check_out_data.dart';
import '../carts_widgets/cart_item_widget.dart';
import '../cubit/toggle_cart_cubit.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<ToggleCartCubit, ToggleCartState>(
      listener: (context, state) {
        if (state is ToggleCartItemsErrorState) {
          showToast(
            message: state.error,
            isError: true,
          );
        } else if (state is ChangeCartListErrorState) {
          showToast(
            message: state.error,
            isError: true,
          );
        }
      },
      child: const CartScreenBuilder(),
    );
  }
}

class CartScreenBuilder extends StatelessWidget {
  const CartScreenBuilder({super.key});

  Future<void> _refreshCartItems(BuildContext context) async {
    await CartsCubit.get(context).getCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToggleCartCubit, ToggleCartState>(
      listener: (context, state) {
        if (state is ToggleCartSuccessState ||
            state is ChangeCartListSuccessState) {
          CartsCubit.get(context).getCartItems();
        }
      },
      builder: (context, state) {
        return BlocBuilder<CartsCubit, CartsState>(
          builder: (context, cartsState) {
            return _CartScreenContent(state: cartsState);
          },
        );
      },
    );
  }
}

class _CartScreenContent extends StatelessWidget {
  final CartsState state;

  const _CartScreenContent({required this.state});

  @override
  Widget build(BuildContext context) {
    var cartModel = CartsCubit.get(context).cartEntity;

    if (cartModel.isEmpty) {
      return const Center(
        child: CustomTitle(
          title: 'Sorry, there are no items in your cart',
          style: TitleStyle.style20,
          color: ColorController.blackColor,
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => CartsCubit.get(context).getCartItems(),
      child: ConditionalBuilder(
        condition: true,
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
        fallback: (context) => Center(
          child: LoadingAnimationWidget.waveDots(
            color: Colors.grey,
            size: 90,
          ),
        ),
      ),
    );
  }
}
