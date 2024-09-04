import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/carts_cubit.dart';
import 'package:shop_app/Features/carts_feature/presentation/cubit/toggle_cart_cubit.dart';
import 'package:shop_app/core/functions/toast_function.dart';
import 'package:shop_app/core/utils/widgets/loading_indicator.dart';

import '../../../../core/payment_gate_way_manager/cubit/payment_cubit.dart';
import '../../../../core/utils/widgets/custom_title.dart';
import '../../../../core/utils/widgets/reusable_widgets_manager/reusable_elevated_botton.dart';
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
        if (state is! GetCartItemsSuccessState) {
          const LoadingIndicatorWidget();
        }
      },
      builder: (context, state) {
        return BlocConsumer<PaymentCubit, PaymentState>(
          listener: (context, state) async {
            if (state is PaymentSuccess) {
              final itemIds =
                  state.model.map((e) => e.id).whereType<num>().toList();

              (await ToggleCartCubit.get(context).changeCartsList(itemIds));
            } else if (state is PaymentError) {
              showToast(message: state.message, isError: true);
            } else if (state is PaymentLoading) {
              const LoadingIndicatorWidget();
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
                    title: 'Total: \$${total?.toStringAsFixed(2) ?? '0.00'}',
                    style: TitleStyle.styleBold20,
                  ),
                  const SizedBox(height: 8),
                  ReusableElevatedButton(
                      label: 'CheckOut',
                      onPressed: () {
                        PaymentCubit.get(context).makePayment(
                          total!.toInt(),
                          'EGP',
                          context,
                          cartModel!,
                        );

                        // PaymentManager.makePayment(
                        //   total!.toInt(),
                        //   'EGP',
                        //   context,
                        //   cartModel!,
                        // );
                      })
                ],
              ),
            );
          },
        );
      },
    );
  }
}
