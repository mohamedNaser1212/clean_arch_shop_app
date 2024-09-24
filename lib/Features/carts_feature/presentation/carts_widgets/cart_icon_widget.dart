import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/carts_cubit.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/toggle_cart_cubit.dart';
import 'package:shop_app/core/functions/dialogue_function.dart';
import 'package:shop_app/core/functions/toast_function.dart';
import 'package:shop_app/core/models/base_products_model.dart';

import 'package:shop_app/core/widgets/custom_icon_botton.dart';

class CartIconWidget extends StatefulWidget {
  const CartIconWidget({super.key, required this.product});
  final BaseProductModel product;

  @override
  State<CartIconWidget> createState() => _CartIconWidgetState();
}

class _CartIconWidgetState extends State<CartIconWidget> {
  int favouriteClickCount = 0;
  int cartClickCount = 0;
  final int maxClickCount = 2;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToggleCartCubit, ToggleCartState>(
      listener: toggleCartListener,
      builder: _builder,
    );
  }

  Widget _builder(context, state) {
    final isCart = CartsCubit.get(context).carts[widget.product.id] ?? false;
    return CustomIconButton.cartButton(
      isCart: isCart,
      onPressed: () => onCartPressed(context, widget.product.id),
    );
  }

  void toggleCartListener(BuildContext context, ToggleCartState state) {
    if (state is ToggleCartItemsErrorState) {
      CartsCubit.get(context).carts[widget.product.id] =
          !(CartsCubit.get(context).carts[widget.product.id] ?? false);
      showToast(
        message: state.error,
      );
    }
  }

  void onCartPressed(BuildContext context, num productId) {
    if (cartClickCount >= maxClickCount) {
      showLimitDialog(
          context: context, text: "Cart", maxClickCount: maxClickCount);
      setState(() {
        cartClickCount = 0;
      });

      CartsCubit.get(context).carts[widget.product.id] =
          !(CartsCubit.get(context).carts[widget.product.id] ?? false);
      return;
    }

    cartClickCount++;
    final cartsCubit = CartsCubit.get(context);
    final isCart = cartsCubit.carts[productId] ?? false;
    cartsCubit.carts[productId] = !isCart;
    ToggleCartCubit.get(context).changeCarts(productId);
  }
}
