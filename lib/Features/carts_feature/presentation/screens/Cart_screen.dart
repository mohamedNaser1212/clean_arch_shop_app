import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/carts_cubit.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/favourites_cubit.dart';
import 'package:shop_app/Features/favourites_feature/presentation/cubit/toggle_favourite_cubit.dart';
import 'package:shop_app/core/payment_gate_way_manager/cubit/payment_cubit.dart';
import 'package:shop_app/core/payment_gate_way_manager/domain/payment_use_case/payment_use_case.dart';
import 'package:shop_app/core/service_locator/service_locator.dart';
import '../../../../core/functions/toast_function.dart';
import '../carts_widgets/cart_content.dart';
import '../cubit/toggle_cart_cubit.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(
        paymentUseCase: getIt.get<PaymentUseCase>(),
      ),
      child: BlocListener<ToggleFavouriteCubit, ToggleFavouriteState>(
        listener: (context, state) {
          if (state is ToggleFavouriteSuccessState) {
            FavouritesCubit.get(context).getFavorites();
          }
        },
        child: BlocListener<ToggleCartCubit, ToggleCartState>(
          listener: (context, state) => _listener(context, state),
          child: BlocBuilder<CartsCubit, CartsState>(
            builder: _cartScreenBuilder,
          ),
        ),
      ),
    );
  }

  Widget _cartScreenBuilder(context, state) {
    if (state is GetCartItemsSuccessState) {
      return CartScreenBody(
        state: state,
      );
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
      ToastFunction.showToast(
        message: state.error,
      );
    } else if (state is ChangeCartListErrorState) {
      ToastFunction.showToast(
        message: state.error,
      );
    } else if (state is ToggleCartSuccessState) {
      CartsCubit.get(context).getCarts();
    }
  }
}
