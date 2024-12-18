import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Features/carts_feature/presentation/carts_widgets/cart_check_out_data.dart';
import 'package:shop_app/Features/carts_feature/presentation/carts_widgets/cart_Payment_widgets.dart';
import 'package:shop_app/core/payment_gate_way/cubit/payment_cubit.dart';
import 'package:shop_app/core/widgets/loading_indicator_widget.dart';

class PaymentConditionalBuilder extends StatelessWidget {
  final PaymentState paymentState;

  final CartCheckoutDataState cartCheckoutDataState;
  const PaymentConditionalBuilder({
    Key? key,
    required this.paymentState,
    required this.cartCheckoutDataState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: paymentState is! InitializePaymentLoadingState,
      builder: (context) {
        return TotalAndCheckOutWidget(
            total: cartCheckoutDataState.widget.total);
      },
      fallback: (context) {
        return const LoadingIndicatorWidget();
      },
    );
  }
}
