import 'package:flutter/material.dart';

import '../../../../core/payment_gate_way_manager/stripe_payment/payment_manager.dart';
import '../../../../core/utils/widgets/custom_title.dart';
import '../../../../core/utils/widgets/reusable_widgets_manager/reusable_elevated_botton.dart';
import '../../domain/cart_entity/add_to_cart_entity.dart';

class CartCheckoutData extends StatelessWidget {
  final num? subtotal;
  final num? total;
  final List<CartEntity>? cartModel;

  const CartCheckoutData({
    super.key,
    required this.subtotal,
    required this.total,
    this.cartModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTitle(
              title: 'Subtotal: \$${subtotal?.toStringAsFixed(2) ?? '0.00'}',
              style: TitleStyle.styleBold18),
          const SizedBox(height: 8),
          CustomTitle(
            title: 'Total: \$${total?.toStringAsFixed(2) ?? '0.00'}',
            style: TitleStyle.styleBold20,
          ),
          const SizedBox(height: 8),
          ReusableElevatedButton(
              label: 'CheckOut',
              onPressed: () {
                PaymentManager.makePayment(
                  total!.toInt(),
                  'EGP',
                  context,
                  cartModel!,
                );
              })
        ],
      ),
    );
  }
}
