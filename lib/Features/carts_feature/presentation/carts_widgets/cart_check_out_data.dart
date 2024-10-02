import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/carts_cubit.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/toggle_cart_cubit.dart';
import 'package:shop_app/core/functions/toast_function.dart';
import 'package:shop_app/core/payment_gate_way_manager/cubit/payment_cubit.dart';
import 'package:shop_app/core/widgets/loading_indicator_widget.dart';
import '../../domain/cart_entity/add_to_cart_entity.dart';
import 'payment_conditional_builder.dart'; 

class CartCheckoutData extends StatefulWidget {
  final num total;
  final List<CartEntity> cartModel;

  const CartCheckoutData({
    super.key,
    required this.total,
    required this.cartModel,
  });

  @override
  State<CartCheckoutData> createState() => CartCheckoutDataState();
}

class CartCheckoutDataState extends State<CartCheckoutData> {
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
          ),
        );
      },
    );
  }

  Widget _builder(
    BuildContext context,
    PaymentState paymentState,
  ) {
    if (widget.cartModel.isEmpty && paymentState is InitializePaymentSuccessState) {
      return const Center(
        child: Text(
          'No items in the cart.',
          style: TextStyle(fontSize: 20, color: Colors.red),
        ),
      );
    }

    return PaymentConditionalBuilder(
      cartCheckoutDataState: this,
      paymentState: paymentState,
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
        widget.cartModel.map((e) => e.id).toList(),
      );

      if (cartUpdated) {
        CartsCubit.get(context).clearCartItems();
        ToastFunction. showToast(
          message: 'Payment Success and Cart Cleared',
          color: Colors.green,
        );
      } else {
         ToastFunction.showToast(
          message: 'Payment Failed',
          color: Colors.red,
        );
      }
    } else if (state is GetClientSecretErrorState) {
      ToastFunction. showToast(
        message: state.message,
      );
    }
  }
}
