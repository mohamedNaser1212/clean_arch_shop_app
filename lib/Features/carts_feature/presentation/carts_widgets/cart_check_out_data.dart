import 'package:flutter/material.dart';

import '../../../../core/utils/screens/widgets/custom_title.dart';
import '../../../../core/utils/screens/widgets/reusable_widgets.dart';
import '../../domain/cart_entity/add_to_cart_entity.dart';
import '../../payment_gate_way/stripe_payment/payment_manager.dart';

class CartCheckoutData extends StatelessWidget {
  final num? subtotal;
  final num? total;
  final List<AddToCartEntity>? cartModel;

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
          // Text(
          //   'Subtotal: \$${subtotal?.toStringAsFixed(2) ?? '0.00'}',
          //   style: const TextStyle(
          //     fontSize: 18,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          const SizedBox(height: 8),
          CustomTitle(
            title: 'Total: \$${total?.toStringAsFixed(2) ?? '0.00'}',
            style: TitleStyle.styleBold20,
          ),
          const SizedBox(height: 8),
          reusableElevatedButton(
              label: 'CheckOut',
              function: () {
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