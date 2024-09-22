import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shop_app/Features/authentication_feature/presentation/widgets/Auth_botton.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/carts_cubit.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/toggle_cart_cubit.dart';
import 'package:shop_app/core/functions/toast_function.dart';
import 'package:shop_app/core/widgets/loading_indicator.dart';

import '../../../../core/payment_gate_way_manager/cubit/payment_cubit.dart';
import '../../../../core/widgets/custom_title.dart';
import '../../../../core/widgets/reusable_widgets/reusable_elevated_botton.dart';
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
      listener: (context, state) {
        if (state is GetClientSecretLoadingState) {
          const LoadingIndicatorWidget();
        }
      },
      builder: (context, state) {
        return BlocConsumer<PaymentCubit, PaymentState>(
          listener: (context, state) async {
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
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  CustomTitle(
                    title: 'Total: \$${total.toStringAsFixed(2)}',
                    style: TitleStyle.styleBold20,
                  ),
                  const SizedBox(height: 8),
                  ReusableElevatedButton(
                    label: 'CheckOut',
                    onPressed: () {
                      PaymentCubit.get(context).getClientSecret(
                        amount: total.toInt(),
                        currency: 'EGP',
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
