import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/get_carts_cubit/carts_cubit.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/toggle_carts_cubit/toggle_cart_cubit.dart';
import 'package:shop_app/core/functions/toast_function.dart';
import 'package:shop_app/core/models/base_products_model.dart';
import 'package:shop_app/core/widgets/custom_icon_bottons_widgets.dart';

class CartIconWidget extends StatefulWidget {
  const CartIconWidget({super.key, required this.product});
  final BaseProductModel product;

  @override
  State<CartIconWidget> createState() => CartIconWidgetState();
}

class CartIconWidgetState extends State<CartIconWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToggleCartCubit, ToggleCartState>(
      listener: toggleCartListener,
      builder: _builder,
    );
  }

  Widget _builder(context, state) {
    final isCart = CartsCubit.get(context).carts[widget.product.id] ?? false;
    return CustomIconButtons.cartButton(
      isCart: isCart,
      context: context,
      state: this,
    );
  }

  Future<void> toggleCartListener(
      BuildContext context, ToggleCartState state) async {
    if (state is ToggleCartItemsErrorState) {
      CartsCubit.get(context).carts[widget.product.id] =
          !(CartsCubit.get(context).carts[widget.product.id] ?? false);
      ToastHelper.showToast(
        message: state.error,
      );
    } else if (state is ToggleCartSuccessState) {
      await CartsCubit.get(context).getCarts();
    }
  }
}
