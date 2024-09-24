import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shop_app/Features/carts_feature/presentation/carts_widgets/total_and_checkout_widget.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/carts_cubit.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/toggle_cart_cubit.dart';
import 'package:shop_app/core/functions/toast_function.dart';
import 'package:shop_app/core/widgets/loading_indicator.dart';
import '../../../../core/payment_gate_way_manager/cubit/payment_cubit.dart';
import '../../domain/cart_entity/add_to_cart_entity.dart';

class CartCheckoutData extends StatelessWidget {
  final num total;
  final List<CartEntity> cartModel;

  const CartCheckoutData({
    super.key,
    required this.total,
    required this.cartModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartsCubit, CartsState>(
      listener: _cartListener,
      builder: (context, cartState) {
        return BlocConsumer<PaymentCubit, PaymentState>(
          listener: _paymentListener,
          builder: (context, paymentState) => _builder(
            context,
            paymentState,
            total,
          ),
        );
      },
    );
  }

  Widget _builder(
    BuildContext context,
    PaymentState paymentState,
    num total,
  ) {
    if (cartModel.isEmpty && paymentState is InitializePaymentSuccessState) {
      return const Center(
        child: Text(
          'No items in the cart.',
          style: TextStyle(fontSize: 20, color: Colors.red),
        ),
      );
    }

    return ConditionalBuilder(
      condition: paymentState is! InitializePaymentLoadingState,
      builder: (context) {
        return TotalAndCheckOutWidget(total: total);
      },
      fallback: (context) {
        return const LoadingIndicatorWidget();
      },
    );
  }

  void _cartListener(BuildContext context, CartsState state) {
    if (state is GetClientSecretLoadingState) {
      const LoadingIndicatorWidget();
    }
  }

  void _paymentListener(BuildContext context, PaymentState state) async {
    if (state is GetClientSecretSuccessState) {
      await PaymentCubit.get(context).makePayment(
        clientSecret: state.clientSecret,
      );
    } else if (state is InitializePaymentSuccessState) {
      await Stripe.instance.presentPaymentSheet();

      bool cartUpdated = await ToggleCartCubit.get(context).changeCartsList(
        cartModel.map((e) => e.id).toList(),
      );

      if (cartUpdated) {
        CartsCubit.get(context).clearCartItems();
        showToast(
          message: 'Payment Success and Cart Cleared',
          color: Colors.green,
        );
      } else {
        showToast(
          message: 'Payment Failed',
          color: Colors.red,
        );
      }
    } else if (state is GetClientSecretErrorState) {
      showToast(
        message: state.message,
      );
    }
  }
}
