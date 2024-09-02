import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/carts_cubit.dart';
import 'package:shop_app/core/payment_gate_way_manager/domain/payment_use_case/payment_use_case.dart';

import '../../../../core/payment_gate_way_manager/cubit/payment_cubit.dart';
import '../../../../core/service_locator/service_locator.dart';
import '../../../../core/utils/styles_manager/color_manager.dart';
import '../../../../core/utils/widgets/custom_title.dart';
import '../../../../core/utils/widgets/reusable_widgets_manager/toast_function.dart';
import '../carts_widgets/cart_check_out_data.dart';
import '../carts_widgets/cart_item_widget.dart';
import '../cubit/toggle_cart_cubit.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PaymentCubit(
            paymentUseCase: getIt.get<PaymentUseCase>(),
          ),
        ),
      ],
      child: BlocBuilder<ToggleCartCubit, ToggleCartState>(
        builder: (context, state) {
          if (state is ToggleCartSuccessState) {
            CartsCubit.get(context).getCartItems();
          } else if (state is ToggleCartItemsErrorState) {
            showToast(
              message: state.error,
              isError: true,
            );
          } else if (state is! ToggleCartSuccessState &&
              state is ToggleCartLoadingState) {
            Center(
              child: LoadingAnimationWidget.waveDots(
                color: Colors.grey,
                size: 90,
              ),
            );
          }

          return BlocConsumer<CartsCubit, CartsState>(
            listener: (context, state) async {
              if (state is ChangeCartListErrorState) {
                showToast(
                  message: state.error,
                  isError: true,
                );
              }
            },
            builder: (context, state) {
              return _CartScreenContent(state: state);
            },
          );
        },
      ),
    );
  }
}

class _CartScreenContent extends StatelessWidget {
  final CartsState state;

  const _CartScreenContent({required this.state});

  @override
  Widget build(BuildContext context) {
    var cartModel = CartsCubit.get(context).cartEntity;
    var subtotal = CartsCubit.get(context).cartSubtotal;
    var total = CartsCubit.get(context).cartTotal;

    if (cartModel.isEmpty) {
      return const Center(
        child: CustomTitle(
          title: 'Sorry, there are no items in your cart',
          style: TitleStyle.style20,
          color: ColorController.blackColor,
        ),
      );
    }

    return ConditionalBuilder(
      condition: state is! ToggleCartLoadingState &&
          state is! GetCartItemsLoadingState,
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
    );
  }
}
