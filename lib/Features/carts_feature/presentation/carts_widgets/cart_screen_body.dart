import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/carts_feature/presentation/carts_widgets/cart_refresh_indicator_widget.dart';
import 'package:shop_app/Features/carts_feature/presentation/carts_widgets/empty_cart_text_widget.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/toggle_carts_cubit/toggle_cart_cubit.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/get_favourites_cubit/favourites_cubit.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/toggle_favourites_cubit/toggle_favourite_cubit.dart';
import 'package:shop_app/core/functions/toast_function.dart';
import 'package:shop_app/core/payment_gate_way/cubit/payment_cubit.dart';
import 'package:shop_app/core/payment_gate_way/domain/payment_use_case/payment_use_case.dart';
import 'package:shop_app/core/service_locator/service_locator.dart';

import '../cubit/get_carts_cubit/carts_cubit.dart';

class CartScreenBody extends StatelessWidget {
  const CartScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(
        paymentUseCase: getIt.get<PaymentUseCase>(),
      ),
      child: BlocListener<ToggleFavouriteCubit, ToggleFavouriteState>(
        listener: _toggleFavouritesListener,
        child: BlocListener<ToggleCartCubit, ToggleCartState>(
          listener: (context, state) => _listener(context, state),
          child: BlocBuilder<CartsCubit, CartsState>(
            builder: _cartScreenBuilder,
          ),
        ),
      ),
    );
  }

  void _toggleFavouritesListener(context, state) {
    if (state is ToggleFavouriteSuccessState) {
      FavouritesCubit.get(context).getFavorites();
    }
  }

  Widget _cartScreenBuilder(context, state) {
    if (state is GetCartItemsSuccessState) {
      var cartModel = CartsCubit.get(context).cartEntity;
    if (cartModel.isEmpty) {
      return const EmptyCartTextWidget();
    }
    return CartRefreshIndicatorWidget(cartModel: cartModel);
    } else if (state is GetCartItemsErrorState) {
      return Center(
        child: Text(state.error),
      );
    } else if (state is GetCartItemsLoadingState) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return const SizedBox.shrink();
  }

  void _listener(BuildContext context, ToggleCartState state) {
    if (state is ToggleCartItemsErrorState) {
      ToastHelper.showToast(
        message: state.error,
      );
    } else if (state is ChangeCartListErrorState) {
      ToastHelper.showToast(
        message: state.error,
      );
    } else if (state is ToggleCartSuccessState) {
      CartsCubit.get(context).getCarts();
    }
  }
}

  
//   }
// }
