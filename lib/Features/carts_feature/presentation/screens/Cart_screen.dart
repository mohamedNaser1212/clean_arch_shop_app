import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/carts_cubit.dart';

import '../../../../core/functions/toast_function.dart';
import '../carts_widgets/cart_content.dart';
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
        } else if (state is ToggleCartSuccessState ||
            state is ChangeCartListSuccessState) {
          CartsCubit.get(context).getCartItems();
        }
      },
      child: CartScreenContent(
        state: CartsCubit.get(context).state,
      ),
    );
  }
}
