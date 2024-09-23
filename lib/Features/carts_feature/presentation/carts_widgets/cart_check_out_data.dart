import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shop_app/features/carts_feature/presentation/carts_widgets/total_and_checkout_widget.dart';
import 'package:shop_app/features/carts_feature/presentation/cubit/carts_cubit.dart';
import 'package:shop_app/features/carts_feature/presentation/cubit/toggle_cart_cubit.dart';
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
      builder: (context, state) {
        return BlocConsumer<PaymentCubit, PaymentState>(
          listener: _paymentListener,
          builder: _builder,
        );
      },
    );
  }

  void _cartListener(context, state) {
      if (state is GetClientSecretLoadingState) {
        const LoadingIndicatorWidget();
      }
    }

  Widget _builder(context, state) {
      return TotalAndCheckOutWidget(total: total);
    }

  void _paymentListener(context, state) async {
      if (state is GetClientSecretSuccessState) {
        await PaymentCubit.get(context).initializePayment(
          clientSecret: state.clientSecret,
        );
        await Stripe.instance.presentPaymentSheet();
      } else if (state is InitializePaymentSuccessState) {
        bool cartUpdated =
            await ToggleCartCubit.get(context).changeCartsList(
          cartModel.map((e) => e.id).toList(),
        );
        showToast(
          message: cartUpdated ? 'Payment Success' : 'Payment Failed',
          isError: !cartUpdated,
        );
      } else if (state is GetClientSecretErrorState) {
        showToast(message: state.message, isError: true);
      }
    }
}


